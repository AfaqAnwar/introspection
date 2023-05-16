import 'package:introspection/data/custom_user.dart';
import 'package:introspection/pages/registration/registration_tabs/information_tab.dart';
import 'package:introspection/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class EducationLevelTab extends StatefulWidget {
  final CustomUser currentUser;
  final Function() updateIndex;
  const EducationLevelTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<EducationLevelTab> createState() => EducationLevelTabState();
}

class EducationLevelTabState extends State<EducationLevelTab>
    with InformationTab {
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

  @override
  String getErrorMessage() {
    return errorMessage;
  }

  @override
  bool validate() {
    if (selectedEducationLevel.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void updateUserInformation() {
    widget.currentUser.setEducationLevel = selectedEducationLevel;
  }

  @override
  String toStringShort() {
    return errorMessage;
  }

  @override
  bool hasChanged() {
    return selectedEducationLevel != widget.currentUser.getEducationLevel;
  }

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
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GroupButton(
                    controller: controller,
                    options: GroupButtonOptions(
                      mainGroupAlignment: MainGroupAlignment.start,
                      crossGroupAlignment: CrossGroupAlignment.start,
                      groupRunAlignment: GroupRunAlignment.start,
                      unselectedColor: Colors.grey,
                      selectedColor: AppStyle.red800,
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    maxSelected: 1,
                    enableDeselect: false,
                    isRadio: true,
                    onSelected: (value, index, isSelected) {
                      if (isSelected) {
                        selectedEducationLevel = value;
                      }
                    },
                    buttons: const [
                      "High School",
                      "Under Graduate",
                      "Post Graduate",
                      "Other",
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
