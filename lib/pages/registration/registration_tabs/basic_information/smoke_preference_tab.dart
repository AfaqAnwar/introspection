import 'package:datingapp/data/current_user.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class SmokePreferenceTab extends StatefulWidget {
  final CurrentUser currentUser;
  final Function() updateIndex;
  const SmokePreferenceTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<SmokePreferenceTab> createState() => SmokePreferenceTabState();
}

class SmokePreferenceTabState extends State<SmokePreferenceTab> {
  final controller = GroupButtonController();

  String smokePreference = "";
  String errorMessage = "Please tell us if you smoke.";

  @override
  void initState() {
    if (widget.currentUser.getSmokePreference.isNotEmpty) {
      smokePreference = widget.currentUser.getSmokePreference;
      if (smokePreference == "Yes") {
        controller.selectIndex(0);
      } else if (smokePreference == "Sometimes") {
        controller.selectIndex(1);
      } else if (smokePreference == "No") {
        controller.selectIndex(2);
      }
    }
    super.initState();
  }

  String getErrorMessage() {
    return errorMessage;
  }

  bool validateSmokePreference() {
    if (smokePreference.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void updateSmokePreferenceOfUser() {
    widget.currentUser.setSmokePreference = smokePreference;
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
                  "Do you smoke?",
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
                        smokePreference = value;
                      }
                    },
                    buttons: const [
                      "Yes",
                      "Sometimes",
                      "No",
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
