import 'dart:io';

import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/pages/home_page_tabs/messaging/chat_page.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class MessageTab extends StatefulWidget {
  final CustomUser currentUser;
  final List<CustomUser> matches;
  const MessageTab(
      {super.key, required this.currentUser, required this.matches});

  @override
  State<MessageTab> createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  List<types.User> users = [];
  bool _isEmpty = true;

  @override
  void initState() {
    super.initState();
    _isEmpty = buildUsers();
  }

  bool buildUsers() {
    List<types.User> users = [];
    for (CustomUser match in widget.matches) {
      users.add(types.User(
          id: match.getUid,
          firstName: match.getFirstName,
          lastName: match.getLastName,
          imageUrl: match.getImages[0]!.path));
    }

    this.users = users;

    if (users.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text("Matches",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Marlide-Display',
                    color: AppStyle.red700))),
        body: FutureBuilder<bool>(
          future: _isEmpty ? Future.value(true) : Future.value(false),
          builder:
              (BuildContext context, AsyncSnapshot<dynamic> futureSnapshot) {
            if (futureSnapshot.data == false) {
              return Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  bottom: 200,
                ),
                child: const Text('No users'),
              );
            }

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];

                return InkWell(
                  enableFeedback: false,
                  splashColor: Colors.transparent,
                  onTap: () {
                    _handlePressed(user, context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(children: [
                      Row(
                        children: [
                          _buildAvatar(widget.matches[index], user),
                          Text(getUserName(user),
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Modern-Era',
                                  color: Colors.black)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Divider(
                        thickness: 0.5,
                        color: Colors.grey[300],
                      ),
                    ]),
                  ),
                );
              },
            );
          },
        ),
      );

  Widget _buildAvatar(CustomUser user, types.User otherUser) {
    final hasImage = user.getImages.isNotEmpty;
    final name = getUserName(otherUser);

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage:
            hasImage ? FileImage(File(user.getImages[0]!.path)) : null,
        radius: 30,
        child: !hasImage
            ? Text(
                name.isEmpty ? '' : name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              )
            : null,
      ),
    );
  }

  void _handlePressed(types.User otherUser, BuildContext context) async {
    final navigator = Navigator.of(context);
    final room = await FirebaseChatCore.instance.createRoom(otherUser);

    await navigator.push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          room: room,
          name: getUserName(otherUser),
        ),
      ),
    );
  }

  String getUserName(types.User user) =>
      '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();
}
