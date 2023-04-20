
import 'package:datingapp/data/custom_user.dart';

import 'dart:ffi';

import 'package:datingapp/style/app_style.dart';
import 'package:datingapp/widgets/conversation_list.dart';
import 'package:flutter/material.dart';

import '../../widgets/chatusers.dart';

class MessageTab extends StatefulWidget {
  final CustomUser currentUser;
  final List<CustomUser> matches;
  const MessageTab(
      {super.key, required this.currentUser, required this.matches});

  @override
  State<MessageTab> createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  List<ChatUsers> users = [
    ChatUsers(
        name: "Sanzida",
        messageText: "BISS",
        imageURL:
            "https://media.licdn.com/dms/image/C4D03AQGj83aveC9otw/profile-displayphoto-shrink_800_800/0/1635120693230?e=2147483647&v=beta&t=Xngetvf8zy6wN6HrUkZbSrbumalHw1bTS99dCHnAT0A",
        time: "Yesterday",
        isMessageRead: true),
    ChatUsers(
        name: "Sandra",
        messageText: "Stinky",
        imageURL:
            "https://media.licdn.com/dms/image/C4D03AQGj83aveC9otw/profile-displayphoto-shrink_800_800/0/1635120693230?e=2147483647&v=beta&t=Xngetvf8zy6wN6HrUkZbSrbumalHw1bTS99dCHnAT0A",
        time: "Now",
        isMessageRead: true),
    ChatUsers(
        name: "Stylinia",
        messageText: "Hello dog",
        imageURL:
            "https://media.licdn.com/dms/image/C4D03AQGj83aveC9otw/profile-displayphoto-shrink_800_800/0/1635120693230?e=2147483647&v=beta&t=Xngetvf8zy6wN6HrUkZbSrbumalHw1bTS99dCHnAT0A",
        time: "Now",
        isMessageRead: false),
    ChatUsers(
        name: "Stylinia",
        messageText: "Hello dog",
        imageURL:
            "https://media.licdn.com/dms/image/C4D03AQGj83aveC9otw/profile-displayphoto-shrink_800_800/0/1635120693230?e=2147483647&v=beta&t=Xngetvf8zy6wN6HrUkZbSrbumalHw1bTS99dCHnAT0A",
        time: "Now",
        isMessageRead: false),
    ChatUsers(
        name: "Stylinia",
        messageText: "Hello dog",
        imageURL:
            "https://media.licdn.com/dms/image/C4D03AQGj83aveC9otw/profile-displayphoto-shrink_800_800/0/1635120693230?e=2147483647&v=beta&t=Xngetvf8zy6wN6HrUkZbSrbumalHw1bTS99dCHnAT0A",
        time: "Now",
        isMessageRead: false),
    ChatUsers(
        name: "Stylinia",
        messageText: "Hello dog",
        imageURL:
            "https://media.licdn.com/dms/image/C4D03AQGj83aveC9otw/profile-displayphoto-shrink_800_800/0/1635120693230?e=2147483647&v=beta&t=Xngetvf8zy6wN6HrUkZbSrbumalHw1bTS99dCHnAT0A",
        time: "Now",
        isMessageRead: false),
  ];

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
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ListView.builder(
              itemCount: users.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ConversationList(
                    name: users[index].name,
                    messageText: users[index].messageText,
                    time: users[index].time,
                    imageUrl: users[index].imageURL,
                    isMessageRead: users[index].isMessageRead);
              }),
        ));
  }
}
