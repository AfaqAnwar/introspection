import 'package:datingapp/components/registration_components/registration_textfield.dart';
import 'package:datingapp/data/current_user.dart';
import 'package:flutter/material.dart';

class JobTitleTab extends StatefulWidget {
  final CurrentUser currentUser;
  final Function() updateIndex;
  const JobTitleTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<JobTitleTab> createState() => JobTitleTabState();
}

class JobTitleTabState extends State<JobTitleTab> {
  final jobTitleController = TextEditingController();
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    if (widget.currentUser.getJobTitle.isNotEmpty) {
      jobTitleController.text = widget.currentUser.getJobTitle;
    }
  }

  void updateJobTitleOfUser() {
    if (textFieldValidation() == true) {
      widget.currentUser.setJobTitle =
          jobTitleController.text.toString().trim();
    }
  }

  bool textFieldValidation() {
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
        Wrap(
<<<<<<< Updated upstream
          children: const [
=======
          children: [
>>>>>>> Stashed changes
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
