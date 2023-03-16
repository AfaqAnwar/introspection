import 'package:datingapp/data/user.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class GenderTab extends StatefulWidget {
  final User currentUser;
  final Function() updateIndex;
  const GenderTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<GenderTab> createState() => GenderTabState();
}

class GenderTabState extends State<GenderTab> {
  final controller = GroupButtonController();

  String selectedGender = "";
  String errorMessage = "Please select your gender.";

  @override
  void initState() {
    if (widget.currentUser.getGender.isNotEmpty) {
      selectedGender = widget.currentUser.getGender;
      if (selectedGender == "Man") {
        controller.selectIndex(0);
      } else {
        controller.selectIndex(1);
      }
    }
    super.initState();
  }

  String getErrorMessage() {
    return errorMessage;
  }

  bool validateGender() {
    if (selectedGender.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void updateUserGender() {
    widget.currentUser.setGender = selectedGender;
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
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  "What's your gender?",
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
                        selectedGender = value;
                      }
                    },
                    buttons: const ["Man", "Woman"],
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
