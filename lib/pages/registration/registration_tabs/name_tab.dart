import 'package:datingapp/components/registration_components/registration_navigation_button.dart';
import 'package:datingapp/components/registration_components/registration_textfield.dart';
import 'package:datingapp/data/user.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';

class NameTab extends StatefulWidget {
  final User currentUser;
  final Function() updateIndex;
  const NameTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<NameTab> createState() => _NameTabState();
}

class _NameTabState extends State<NameTab> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    if (widget.currentUser.firstName.isNotEmpty) {
      firstNameController.text = widget.currentUser.getFirstName;
    }
    if (widget.currentUser.lastName.isNotEmpty) {
      lastNameController.text = widget.currentUser.getLastName;
    }
  }

  bool textFieldValidation() {
    if (firstNameController.text.trim().isEmpty) {
      errorMessage = "Please enter your first name.";
      return false;
    } else if (isNumeric(firstNameController.text.trim())) {
      errorMessage = "Please enter a valid first name.";
      return false;
    } else if (lastNameController.text.trim().isNotEmpty) {
      if (isNumeric(lastNameController.text.trim())) {
        errorMessage = "Please enter a valid last name.";
        return false;
      }
    }
    return true;
  }

  final RegExp _numeric = RegExp(r'^-?[0-9]+$');

  bool isNumeric(String str) {
    return _numeric.hasMatch(str);
  }

  bool nameValidation() {
    if (textFieldValidation() == true) {
      widget.currentUser.setFirstName =
          firstNameController.text.toString().trim();
      widget.currentUser.setLastName =
          lastNameController.text.toString().trim();
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
                "What's Your Name?",
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
            controller: firstNameController,
            hintText: "First Name",
            obscureText: false),
        const SizedBox(height: 50),
        RegistrationTextField(
            controller: lastNameController,
            hintText: "Last Name (optional)",
            obscureText: false),
        const SizedBox(height: 50),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: RegistrationNavigationButton(
              updateIndexFunction: widget.updateIndex,
              secondaryFunction: () {
                if (nameValidation() == false) {
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
              }),
        ),
      ],
    );
  }
}
