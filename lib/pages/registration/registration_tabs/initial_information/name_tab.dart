import 'package:datingapp/components/registration_authentication_components/registration_textfield.dart';
import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/pages/registration/registration_tabs/information_tab.dart';
import 'package:flutter/material.dart';

class NameTab extends StatefulWidget {
  final CustomUser currentUser;
  final Function() updateIndex;
  const NameTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<NameTab> createState() => NameTabState();
}

class NameTabState extends State<NameTab> with InformationTab {
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

  @override
  bool validate() {
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

  @override
  void updateUserInformation() {
    if (validate() == true) {
      widget.currentUser.setFirstName =
          firstNameController.text.toString().trim();
      widget.currentUser.setLastName =
          lastNameController.text.toString().trim();
    }
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
  bool hasChanged() {
    if (firstNameController.text.trim() != widget.currentUser.getFirstName ||
        lastNameController.text.trim() != widget.currentUser.getLastName) {
      return true;
    }
    return false;
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
                "What's your name?",
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
            controller: firstNameController,
            hintText: "First Name (Required)",
            obscureText: false),
        const SizedBox(height: 50),
        RegistrationTextField(
            controller: lastNameController,
            hintText: "Last Name",
            obscureText: false),
      ],
    );
  }
}
