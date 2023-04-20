import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/helpers/firebase_login_helper.dart';
import 'package:datingapp/helpers/firebase_storage_manager.dart';
import 'package:datingapp/pages/home_page_host.dart';
import 'package:datingapp/pages/personaility_chat/personailty_chat_page.dart';
import 'package:datingapp/pages/signin_signup/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  Future<CustomUser> buildUser() async {
    FirebaseLoginHelper helper = FirebaseLoginHelper();
    await helper.populateUserData();
    CustomUser currentUser = helper.getCurrentUser();
    var firebaseUser = FirebaseAuth.instance.currentUser;

    FirebaseStorageManager storageManager =
        FirebaseStorageManager(firebaseUser!.uid);

    Map<int, XFile> images = await storageManager.getImages();

    currentUser.setImages = images;

    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: buildUser(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> futureSnapshot) {
        if (futureSnapshot.hasData) {
          CustomUser user = futureSnapshot.data;
          return Scaffold(
            body: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (user.getPersonalityType.isEmpty) {
                      return PersonailtyChatPage(
                        currentUser: user,
                      );
                    } else if (user.isBuilt()) {
                      return HomePageHost(
                        currentUser: user,
                      );
                    }
                    return const LoginPage();
                  } else {
                    return const LoginPage();
                  }
                }),
          );
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
