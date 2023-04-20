import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';

class MessageTab extends StatefulWidget {
  final List<CustomUser> matches;
  const MessageTab({super.key, required this.matches});

  @override
  State<MessageTab> createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("Messages",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Marlide-Display',
                  color: AppStyle.red700))),
    );
  }
}
