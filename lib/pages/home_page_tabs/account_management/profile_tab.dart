import 'dart:io';

import 'package:datingapp/components/profile_tab_components/profile_row_tile.dart';
import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/pages/home_page_tabs/account_management/account_page.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  final CustomUser currentUser;
  const ProfileTab({super.key, required this.currentUser});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text("Profile",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Marlide-Display',
                    color: AppStyle.red700))),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 175.0,
                  height: 175.0,
                  decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: DecorationImage(
                      image: FileImage(
                          File(widget.currentUser.getImages[0]!.path)),
                      fit: BoxFit.cover,
                    ),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(200.0)),
                    border: Border.all(
                      color: AppStyle.red600,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                  "${widget.currentUser.getFirstName} ${widget.currentUser.getLastName}",
                  style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Modern-Era',
                      color: Colors.black)),
              const SizedBox(height: 50),
              Divider(
                thickness: 0.5,
                color: Colors.grey[300],
              ),
              ProfileRowTile(
                  text: "Preferences",
                  icon: CupertinoIcons.slider_horizontal_3,
                  onTap: () {}),
              ProfileRowTile(
                  text: "Account",
                  icon: CupertinoIcons.settings,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AccountPage(currentUser: widget.currentUser)),
                    );
                  }),
              const ProfileRowTile(
                  text: "Help Center",
                  icon: CupertinoIcons.question,
                  onTap: null),
            ],
          ),
        ));
  }
}