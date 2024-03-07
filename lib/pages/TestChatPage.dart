import 'package:flutter/material.dart';

class TESTChatPage extends StatefulWidget {
  final String receiverUserEmail;
  // final String receiverUserId;
  const TESTChatPage({
    super.key,
    required this.receiverUserEmail,
    // required this.receiverUserId,
  });

  @override
  State<TESTChatPage> createState() => _TESTChatPageState();
}

class _TESTChatPageState extends State<TESTChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverUserEmail)),
    );
  }
}