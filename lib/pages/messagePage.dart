import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
  

class _MessagePage extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // box that allows the widget to be scrolled through for list of confirmed match list
      body: SingleChildScrollView(
          // provides the effect of the scrolling if a user scrolls all the way towards the bottom it bounces back to the top of the list
          physics: BounchingScrollPhysics(),
          child: Column(
            crossAxisAlignment: crossAxisAlignment.start,
            children: <Widget>[
              SafeArea(
                children: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top:10),
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.red[50]
                  ),
    

                )
              )
            ]








          )),
    );
  }
}
