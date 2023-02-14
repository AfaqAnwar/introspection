import 'package:datingapp/pages/home_page_host.dart';
import 'package:datingapp/pages/registration_signup/login_page.dart';
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
              return const HomePageHost();
            } else {
              return const LoginPage();
            }
          }),
    );
  }
}
