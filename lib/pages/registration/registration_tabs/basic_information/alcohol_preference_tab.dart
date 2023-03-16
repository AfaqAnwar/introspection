import 'package:datingapp/data/user.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class AlcoholPreferenceTab extends StatefulWidget {
  final User currentUser;
  final Function() updateIndex;
  const AlcoholPreferenceTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<AlcoholPreferenceTab> createState() => AlcoholPreferenceTabState();
}

class AlcoholPreferenceTabState extends State<AlcoholPreferenceTab> {
  final controller = GroupButtonController();

  String selectedAlcoholPreference = "";
  String errorMessage = "Please tell us if you drink.";

  @override
  void initState() {
    if (widget.currentUser.getAlcoholPreference.isNotEmpty) {
      selectedAlcoholPreference = widget.currentUser.getAlcoholPreference;
      if (selectedAlcoholPreference == "Yes") {
        controller.selectIndex(0);
      } else if (selectedAlcoholPreference == "Sometimes") {
        controller.selectIndex(1);
      } else if (selectedAlcoholPreference == "No") {
        controller.selectIndex(2);
      }
    }
    super.initState();
  }

  String getErrorMessage() {
    return errorMessage;
  }

  bool validateAlcoholPreference() {
    if (selectedAlcoholPreference.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void updateAlcoholPreferenceOfUser() {
    widget.currentUser.setAlcoholPreference = selectedAlcoholPreference;
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
                  "Do you drink?",
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
                        selectedAlcoholPreference = value;
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