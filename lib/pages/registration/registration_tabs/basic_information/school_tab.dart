import 'package:introspection/components/registration_authentication_components/registration_textfield.dart';
import 'package:introspection/data/custom_user.dart';
import 'package:introspection/pages/registration/registration_tabs/information_tab.dart';
import 'package:flutter/material.dart';

class SchoolTab extends StatefulWidget {
  final CustomUser currentUser;
  final Function() updateIndex;
  const SchoolTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<SchoolTab> createState() => SchoolTabState();
}

class SchoolTabState extends State<SchoolTab> with InformationTab {
  final schoolController = TextEditingController();

  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    if (widget.currentUser.getSchool.isNotEmpty) {
      schoolController.text = widget.currentUser.getSchool;
    }
  }

  @override
  bool validate() {
    if (schoolController.text.trim().isEmpty) {
      errorMessage = "Please enter where you went to school.";
      return false;
    }
    return true;
  }

  @override
  void updateUserInformation() {
    if (validate() == true) {
      widget.currentUser.setSchool = schoolController.text.toString().trim();
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
    return widget.currentUser.getSchool != schoolController.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Wrap(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Where did you go to school?",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontFamily: 'Marlide-Display',
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ]),
        const SizedBox(height: 25),
        RegistrationTextField(
            controller: schoolController,
            hintText: "Add a school",
            obscureText: false),
      ],
    );
  }
}
