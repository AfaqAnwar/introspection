import 'package:flutter/material.dart';

class MessagesPage extends StatefulWidget {
  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(child: Text("Messages")),
      ),
    );
  }
}



return Scaffold(
  body: SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Messages", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Container(
                  padding: EdgeInsets.only(left: 7, right: 7, top: 2, bottom: 2),
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppStyle.red800,
                  ),
                  child: Text("Button Text"),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);
