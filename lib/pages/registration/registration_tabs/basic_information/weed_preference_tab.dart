import 'package:datingapp/data/current_user.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class WeedPreferenceTab extends StatefulWidget {
  final CurrentUser currentUser;
  final Function() updateIndex;
  const WeedPreferenceTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<WeedPreferenceTab> createState() => WeedPreferenceTabState();
}

class WeedPreferenceTabState extends State<WeedPreferenceTab> {
  final controller = GroupButtonController();

  String weedPreference = "";
  String errorMessage = "Please tell us if you smoke weed.";

  @override
  void initState() {
    if (widget.currentUser.getWeedPreference.isNotEmpty) {
      weedPreference = widget.currentUser.getWeedPreference;
      if (weedPreference == "Yes") {
        controller.selectIndex(0);
      } else if (weedPreference == "Sometimes") {
        controller.selectIndex(1);
      } else if (weedPreference == "No") {
        controller.selectIndex(2);
      }
    }
    super.initState();
  }

  String getErrorMessage() {
    return errorMessage;
  }

  bool validateWeedPreference() {
    if (weedPreference.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void updateWeedPreferenceOfUser() {
    widget.currentUser.setWeedPreference = weedPreference;
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
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  "Do you smoke weed?",
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
                        weedPreference = value;
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
