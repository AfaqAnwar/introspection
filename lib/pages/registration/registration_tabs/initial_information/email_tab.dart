import 'package:datingapp/components/registration_authentication_components/registration_textfield.dart';
import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/pages/registration/registration_tabs/information_tab.dart';
import 'package:flutter/material.dart';

class EmailTab extends StatefulWidget {
  final CustomUser currentUser;
  final Function() updateIndex;
  const EmailTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<EmailTab> createState() => EmailTabState();
}

class EmailTabState extends State<EmailTab> with InformationTab {
  final emailTextController = TextEditingController();

  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    if (widget.currentUser.firstName.isNotEmpty) {
      emailTextController.text = widget.currentUser.getEmail;
    }
  }

  @override
  bool validate() {
    if (!emailTextController.text.toString().trim().contains("@")) {
      errorMessage = "Please enter a valid email address.";
      return false;
    } else if (!emailTextController.text.toString().trim().contains(".")) {
      errorMessage = "Please enter a valid email address.";
      return false;
    }
    return true;
  }

  @override
  void updateUserInformation() {
    if (validate() == true) {
      widget.currentUser.setEmail = emailTextController.text.toString().trim();
    }
  }

  @override
  String getErrorMessage() {
    return errorMessage;
  }

  @override
  bool hasChanged() {
    return widget.currentUser.getEmail !=
        emailTextController.text.toString().trim();
  }

  @override
  String toStringShort() {
    return errorMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "What's your email?",
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
            controller: emailTextController,
            hintText: "Email",
            obscureText: false),
        const SizedBox(height: 100),
      ],
    );
  }
}
