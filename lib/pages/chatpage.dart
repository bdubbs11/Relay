import 'package:flutter/material.dart';
import 'package:relay/colors/colors.dart';
import 'package:relay/components/navbar.dart';
import 'package:relay/pages/myhomepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatPage extends StatefulWidget {
  final String contactName;
  final String userName;

  const ChatPage({
    Key? key,
    required this.contactName,
    required this.userName,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  final List<String> messages = [];

  void addMessage(String message) {
    setState(() {
      messages.add(message);
    });
  }

  void sendMessage(String conversationId) {
    String messageText = messageController.text.trim();

    if (messageText.isNotEmpty) {
      FirebaseFirestore.instance
        .collection('conversations')
        .doc(conversationId)
        .collection('chatMessages')
        .add({
      'sender': widget.userName,
      'text': messageText,
      'timestamp': FieldValue.serverTimestamp(),
      }).then((value) {
      }).catchError((error) {
      });
      setState(() {
        messages.add(messageText);
      });
      messageController.clear();
    }
  }

  Widget chat() {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        if (index < messages.length) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: AppColors.relayBlue,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    messages[index],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        } else {
          return null; // or any other fallback widget if needed
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(widget.contactName),
        backgroundColor: AppColors.relayBlue,
        leading: IconButton(
          icon: Image.asset("lib/images/blackLogo.png"),
          onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('conversations')
                      .doc('njgadaILA0g4uP0hT8hA') // Replace with the actual conversation ID
                      .collection('chatMessages')
                      .orderBy('timestamp') // Assuming you want to order messages by timestamp
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    var messages = snapshot.data!.docs;
                    List<Widget> messageWidgets = [];

                    for (var message in messages) {
                      var sender = message['sender'];
                      var messageText = message['text'];
                      var alignment = (sender == widget.userName) ? Alignment.centerRight : Alignment.centerLeft;
                      var messageWidget = Align(
                        alignment: alignment,
                        child: Container(
                          margin: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 50.0, right: 50.0),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: (sender == widget.contactName) ? AppColors.relayBlue : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            messageText,
                            style: TextStyle(color: (sender == widget.contactName) ? Colors.white : Colors.black), // Adjust text color based on sender
                          ),
                        ),
                      );

                      messageWidgets.add(messageWidget);
                    }

                    return ListView(
                      children: messageWidgets,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type your message...',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        sendMessage('njgadaILA0g4uP0hT8hA');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyNavBar(currentIndex: (1)),
    );
  }
}
