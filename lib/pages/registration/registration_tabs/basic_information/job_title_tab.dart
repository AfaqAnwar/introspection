import 'package:datingapp/components/registration_authentication_components/registration_textfield.dart';
import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/pages/registration/registration_tabs/information_tab.dart';
import 'package:flutter/material.dart';

class JobTitleTab extends StatefulWidget {
  final CustomUser currentUser;
  final Function() updateIndex;
  const JobTitleTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<JobTitleTab> createState() => JobTitleTabState();
}

class JobTitleTabState extends State<JobTitleTab> with InformationTab {
  final jobTitleController = TextEditingController();
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    if (widget.currentUser.getJobTitle.isNotEmpty) {
      jobTitleController.text = widget.currentUser.getJobTitle;
    }
  }

  @override
  void updateUserInformation() {
    if (validate() == true) {
      widget.currentUser.setJobTitle =
          jobTitleController.text.toString().trim();
    }
  }

  @override
  bool validate() {
    if (isNumeric(jobTitleController.text.trim())) {
      errorMessage = "Please enter a valid job title.";
      return false;
    }
    return true;
  }

  final RegExp _numeric = RegExp(r'^-?[0-9]+$');

  bool isNumeric(String str) {
    return _numeric.hasMatch(str);
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
    return jobTitleController.text != widget.currentUser.getJobTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  "What's your job title?",
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
            controller: jobTitleController,
            hintText: "Add a job title.",
            obscureText: false),
      ],
    );
  }
}
