import 'package:introspection/data/custom_user.dart';
import 'package:introspection/helpers/firebase_login_helper.dart';
import 'package:introspection/helpers/firebase_storage_manager.dart';
import 'package:introspection/pages/future_home_buffer_builder.dart';
import 'package:introspection/pages/personaility_chat/personailty_chat_page.dart';
import 'package:introspection/pages/signin_signup/login_page.dart';
import 'package:introspection/style/app_style.dart';
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
                      return FutureHomeBufferBuilder(
                        currentUser: user,
                      );
                    }
                  }
                  return Scaffold(
                    backgroundColor: Colors.white,
                    body: Center(
                      child: CircularProgressIndicator(color: AppStyle.red900),
                    ),
                  );
                }),
          );
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
