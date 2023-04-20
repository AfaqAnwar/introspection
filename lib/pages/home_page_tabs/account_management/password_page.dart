import 'package:datingapp/components/registration_authentication_components/registration_textfield.dart';
import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/pages/registration/registration_tabs/information_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordPage extends StatefulWidget {
  final CustomUser currentUser;
  final Function() updateIndex;
  const PasswordPage(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<PasswordPage> createState() => PasswordPageState();
}

class PasswordPageState extends State<PasswordPage> with InformationTab {
  final password = TextEditingController();
  final confirmedPassword = TextEditingController();

  String errorMessage = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  bool validate() {
    if (password.text.trim().isEmpty) {
      errorMessage = "Please enter a password.";
      return false;
    } else if (confirmedPassword.text.trim().isEmpty) {
      errorMessage = "Please confirm your password.";
      return false;
    } else if (password.text.trim() != confirmedPassword.text.trim()) {
      errorMessage = "Passwords do not match.";
      return false;
    }
    return true;
  }

  @override
  String getErrorMessage() {
    return errorMessage;
  }

  @override
  String toStringShort() {
    return errorMessage;
  }

  @override
  Future updateUserInformation() async {
    await FirebaseAuth.instance.currentUser!
        .updatePassword(password.text.trim());
  }

  @override
  bool hasChanged() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Wrap(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Please enter a password.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontFamily: 'Marlide-Display',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ]),
        const SizedBox(height: 25),
        RegistrationTextField(
            controller: password, hintText: "Password", obscureText: true),
        const SizedBox(height: 50),
        RegistrationTextField(
            controller: confirmedPassword,
            hintText: "Confirm Password",
            obscureText: true),
      ],
    );
  }
}
