import 'package:flutter/material.dart';

class ChatroomScreen extends StatefulWidget {

  final String chatroomKey;

  const ChatroomScreen({Key? key, required this.chatroomKey}) : super(key: key);

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.yellowAccent,
    child: Text(widget.chatroomKey),);
  }
}
