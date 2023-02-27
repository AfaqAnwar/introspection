import 'package:datingapp/components/registration_components/registration_navigation_button.dart';
import 'package:datingapp/components/registration_components/registration_textfield.dart';
import 'package:datingapp/data/user.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';

class EmailTab extends StatefulWidget {
  final User currentUser;
  final Function() updateIndex;
  const EmailTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<EmailTab> createState() => _EmailTabState();
}

class _EmailTabState extends State<EmailTab> {
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

  bool emailValidation() {
    if (emailTextValidation() == true) {
      widget.currentUser.setEmail = emailTextController.text.toString().trim();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "What's Your Email?",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontFamily: 'Marlide-Display',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        RegistrationTextField(
            controller: emailTextController,
            hintText: "Email",
            obscureText: false),
        const SizedBox(height: 100),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          RegistrationNavigationButton(
              updateIndexFunction: widget.updateIndex,
              secondaryFunction: () {
                if (emailValidation() == false) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            title: const Text('Whoops!'),
                            content: Text(errorMessage.toString()),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  "Okay",
                                  style: TextStyle(color: AppStyle.red800),
                                ),
                              )
                            ],
                          ));
                } else {
                  return true;
                }
              })
        ]),
      ],
    );
  }
}
