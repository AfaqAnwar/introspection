import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/helpers/firebase_login.dart';
import 'package:datingapp/pages/home_page_host.dart';
import 'package:datingapp/pages/personaility_chat/personailty_chat_page.dart';
import 'package:datingapp/pages/signin_signup/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  Future<CustomUser> buildUser() async {
    FirebaseLoginHelper helper = FirebaseLoginHelper();
    await helper.populateUserData();
    return helper.getCurrentUser();
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
