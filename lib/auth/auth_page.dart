import 'package:datingapp/data/current_user.dart';
import 'package:datingapp/helpers/firebase_login.dart';
import 'package:datingapp/pages/home_page_host.dart';
import 'package:datingapp/pages/personaility_chat/personailty_chat_page.dart';
import 'package:datingapp/pages/signin_signup/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // User Logged In or Not
            if (snapshot.hasData) {
              FirebaseLoginHelper helper = FirebaseLoginHelper();
              helper.populateUserData();
              CurrentUser currentUser = helper.getCurrentUser();
              if (currentUser.getPersonalityType.isEmpty) {
                return PersonailtyChatPage(
                  currentUser: currentUser,
                );
              } else {
                return HomePageHost(
                  currentUser: currentUser,
                );
              }
            } else {
              return const LoginPage();
            }
          }),
    );
  }
}
