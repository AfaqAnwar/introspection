import 'package:datingapp/components/registration_authentication_components/registration_textfield.dart';
import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/pages/registration/registration_tabs/information_tab.dart';
import 'package:flutter/material.dart';

class HometownTab extends StatefulWidget {
  final CustomUser currentUser;
  final Function() updateIndex;
  const HometownTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<HometownTab> createState() => HometownTabState();
}

class HometownTabState extends State<HometownTab> with InformationTab {
  final hometownController = TextEditingController();

  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    if (widget.currentUser.getHometown.isNotEmpty) {
      hometownController.text = widget.currentUser.getHometown;
    }
  }

  @override
  bool validate() {
    if (hometownController.text.trim().isEmpty) {
      errorMessage = "Please enter your hometown.";
      return false;
    } else if (isNumeric(hometownController.text.trim())) {
      errorMessage = "Please enter a valid hometown.";
      return false;
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
      widget.currentUser.setHometown =
          hometownController.text.toString().trim();
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
    return hometownController.text != widget.currentUser.getHometown;
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Wrap(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  "Where's your hometown?",
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
          ],
        ),
        const SizedBox(height: 25),
        RegistrationTextField(
            controller: hometownController,
            hintText: "Queens, NY",
            obscureText: false),
      ],
    );
  }
}
