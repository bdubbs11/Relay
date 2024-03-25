import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:relay/colors/colors.dart';
import 'package:relay/components/navbar.dart';
import 'package:relay/pages/myhomepage.dart';

class TestChatPage extends StatefulWidget {
  final String contactName;
  final String userName;

  const TestChatPage({
    Key? key,
    required this.contactName,
    required this.userName,
  }) : super(key: key);

  @override
  State<TestChatPage> createState() => TestChatPageState();
}

class TestChatPageState extends State<TestChatPage> {
  final TextEditingController messageController = TextEditingController();
  final List<String> messages = [];

  late DatabaseReference messagesReference;

  @override
void initState() {
  super.initState();
  String conversationId = generateConversationId(widget.contactName, widget.userName);
  messagesReference = FirebaseDatabase.instance.ref().child('conversations').child(conversationId);
  messagesReference.onChildAdded.listen((event) {
    setState(() {
      messages.add(event.snapshot.value.toString());
    });
  });
}

  String generateConversationId(String user1, String user2) {
    List<String> sortedUsernames = [user1, user2]..sort();
    return sortedUsernames.join('_');
  }

  void sendMessage(String message) {
    if (message.isNotEmpty) {
      messagesReference.push().set({
        'sender': widget.userName,
        'text': message,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
      messageController.clear();
    }
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
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final messageData = messages[index];
                    final sender = messageData.substring(messageData.indexOf('sender: ') + 8, messageData.indexOf(', text: '));
                    final text = messageData.substring(messageData.indexOf('text: ') + 6, messageData.indexOf(', time'));
                    final isCurrentUser = sender == widget.userName;
                    final maxWidth = MediaQuery.of(context).size.width * 0.8;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                        children: [
                          isCurrentUser
                              ? SizedBox(width: 8)
                              : SizedBox(width: 0),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            child: Align(
                              alignment: isCurrentUser ? Alignment.topRight : Alignment.topLeft,
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: isCurrentUser ? AppColors.relayBlue : Colors.grey[300]!,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      sender,
                                      style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      text,
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          !isCurrentUser
                              ? SizedBox(width: 8)
                              : SizedBox(width: 0),
                        ],
                      ),
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
                        sendMessage(messageController.text.trim());
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