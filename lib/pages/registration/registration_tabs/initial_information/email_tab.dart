import 'package:datingapp/components/registration_authentication_components/registration_textfield.dart';
import 'package:datingapp/data/custom_user.dart';
import 'package:flutter/material.dart';

class EmailTab extends StatefulWidget {
  final CustomUser currentUser;
  final Function() updateIndex;
  const EmailTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<EmailTab> createState() => EmailTabState();
}

class EmailTabState extends State<EmailTab> {
  final emailTextController = TextEditingController();

  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    if (widget.currentUser.firstName.isNotEmpty) {
      emailTextController.text = widget.currentUser.getEmail;
    }
  }

  bool emailTextValidation() {
    if (!emailTextController.text.toString().trim().contains("@")) {
      errorMessage = "Please enter a valid email address.";
      return false;
    } else if (!emailTextController.text.toString().trim().contains(".")) {
      errorMessage = "Please enter a valid email address.";
      return false;
    }
    return true;
  }

  void updateUserEmail() {
    if (emailTextValidation() == true) {
      widget.currentUser.setEmail = emailTextController.text.toString().trim();
    }
  }

  String getErrorMessage() {
    return errorMessage;
  }

  @override
  String toStringShort() {
    return errorMessage;
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
