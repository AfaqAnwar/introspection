import 'package:datingapp/data/user.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class EducationLevelTab extends StatefulWidget {
  final User currentUser;
  final Function() updateIndex;
  const EducationLevelTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<EducationLevelTab> createState() => EducationLevelTabState();
}

class EducationLevelTabState extends State<EducationLevelTab> {
  final controller = GroupButtonController();

  String selectedEducationLevel = "";
  String errorMessage = "Please select your higest level of education.";

  @override
  void initState() {
    if (widget.currentUser.getEducationLevel.isNotEmpty) {
      selectedEducationLevel = widget.currentUser.getEducationLevel;
      if (selectedEducationLevel == "High School") {
        controller.selectIndex(0);
      } else if (selectedEducationLevel == "Under Graduate") {
        controller.selectIndex(1);
      } else if (selectedEducationLevel == "Post Graduate") {
        controller.selectIndex(2);
      } else if (selectedEducationLevel == "Other") {
        controller.selectIndex(4);
      }
    }
    super.initState();
  }

  String getErrorMessage() {
    return errorMessage;
  }

  bool validateEducationLevel() {
    if (selectedEducationLevel.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void udpateEducationLevelOfUser() {
    widget.currentUser.setEducationLevel = selectedEducationLevel;
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
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "What's your highest level of education?",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontFamily: 'Marlide-Display',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GroupButton(
                  controller: controller,
                  options: GroupButtonOptions(
                    unselectedColor: Colors.grey,
                    selectedColor: AppStyle.red800,
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                  ),
                  maxSelected: 1,
                  enableDeselect: true,
                  isRadio: false,
                  onSelected: (value, index, isSelected) {
                    if (isSelected) {
                      selectedEducationLevel = value;
                    } else {
                      selectedEducationLevel = "";
                    }
                  },
                  buttons: const [
                    "High School",
                    "Under Graduate",
                    "Post Graduate",
                    "Other",
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
