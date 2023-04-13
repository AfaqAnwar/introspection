import 'package:datingapp/components/registration_components/registration_textfield.dart';
import 'package:datingapp/data/CustomUser.dart';
import 'package:flutter/material.dart';

class SchoolTab extends StatefulWidget {
  final CustomUser currentUser;
  final Function() updateIndex;
  const SchoolTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<SchoolTab> createState() => SchoolTabState();
}

class SchoolTabState extends State<SchoolTab> {
  final schoolController = TextEditingController();

  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    if (widget.currentUser.getSchool.isNotEmpty) {
      schoolController.text = widget.currentUser.getSchool;
    }
  }

  bool textFieldValidation() {
    if (schoolController.text.trim().isEmpty) {
      errorMessage = "Please enter where you went to school.";
      return false;
    }
    return true;
  }

  void updateSchoolOfUser() {
    if (textFieldValidation() == true) {
      widget.currentUser.setSchool = schoolController.text.toString().trim();
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
        Wrap(children: const [
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
