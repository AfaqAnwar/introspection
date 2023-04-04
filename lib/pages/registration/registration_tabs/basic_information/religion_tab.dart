import 'package:datingapp/data/current_user.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class ReligionTab extends StatefulWidget {
  final CurrentUser currentUser;
  final Function() updateIndex;
  const ReligionTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<ReligionTab> createState() => ReligionTabState();
}

class ReligionTabState extends State<ReligionTab> {
  final controller = GroupButtonController();

  String selectedReligion = "";
  String errorMessage = "Please select your religion, if any at all.";

  @override
  void initState() {
    if (widget.currentUser.getReligion.isNotEmpty) {
      selectedReligion = widget.currentUser.getReligion;
      if (selectedReligion == "Bhuddist") {
        controller.selectIndex(0);
      } else if (selectedReligion == "Catholic") {
        controller.selectIndex(1);
      } else if (selectedReligion == "Christain") {
        controller.selectIndex(2);
      } else if (selectedReligion == "Hindu") {
        controller.selectIndex(4);
      } else if (selectedReligion == "Jewish") {
        controller.selectIndex(5);
      } else if (selectedReligion == "Muslim") {
        controller.selectIndex(6);
      } else if (selectedReligion == "Spiritual") {
        controller.selectIndex(7);
      } else if (selectedReligion == "Agnostic") {
        controller.selectIndex(8);
      } else if (selectedReligion == "Atheist") {
        controller.selectIndex(9);
      } else if (selectedReligion == "Other") {
        controller.selectIndex(10);
      } else if (selectedReligion == "None") {
        controller.selectIndex(11);
      }
    }
    super.initState();
  }

  String getErrorMessage() {
    return errorMessage;
  }

  bool validateReligion() {
    if (selectedReligion.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void updateReligionOfUser() {
    widget.currentUser.setReligion = selectedReligion;
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
                  "What are your religious beliefs?",
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
                        selectedReligion = value;
                      }
                    },
                    buttons: const [
                      "Bhuddist",
                      "Catholic",
                      "Christain",
                      "Hindu",
                      "Jewish",
                      "Muslim",
                      "Spiritual",
                      "Agnostic",
                      "Atheist",
                      "Other",
                      "None",
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
