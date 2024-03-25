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
  // Adjust the reference to fetch messages from the appropriate conversation based on usernames
  String conversationId = generateConversationId(widget.contactName, widget.userName);
  messagesReference = FirebaseDatabase.instance.ref().child('conversations').child(conversationId);
  messagesReference.onChildAdded.listen((event) {
    setState(() {
      messages.add(event.snapshot.value.toString()); // Cast to String
    });
  });
}

  String generateConversationId(String user1, String user2) {
    // Custom logic to generate a unique conversation ID based on the usernames
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
                    final messageParts = messages[index].split(", ");
                    final textPart = messageParts
                      .firstWhere((part) => part.startsWith("text:"))
                      .substring("text: ".length);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: AppColors.relayBlue,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                textPart,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
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