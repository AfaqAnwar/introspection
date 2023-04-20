import 'package:datingapp/components/registration_authentication_components/registration_textfield.dart';
import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/pages/registration/registration_tabs/information_tab.dart';
import 'package:flutter/material.dart';

class WorkTab extends StatefulWidget {
  final CustomUser currentUser;
  final Function() updateIndex;
  const WorkTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<WorkTab> createState() => WorkTabState();
}

class WorkTabState extends State<WorkTab> with InformationTab {
  final workController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.currentUser.getWork.isNotEmpty) {
      workController.text = widget.currentUser.getWork;
    }
  }

  @override
  void updateUserInformation() {
    widget.currentUser.setWork = workController.text.toString().trim();
  }

  @override
  String getErrorMessage() {
    return "";
  }

  @override
  bool validate() {
    return true;
  }

  @override
  bool hasChanged() {
    return workController.text != widget.currentUser.getWork;
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
                  "Where do you work?",
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
            controller: workController,
            hintText: "Add a workplace",
            obscureText: false),
      ],
    );
  }
}
