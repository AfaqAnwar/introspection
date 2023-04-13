import 'package:datingapp/data/CustomUser.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class GenderPreferenceTab extends StatefulWidget {
  final CustomUser currentUser;
  final Function() updateIndex;
  const GenderPreferenceTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<GenderPreferenceTab> createState() => GenderPreferenceTabState();
}

class GenderPreferenceTabState extends State<GenderPreferenceTab> {
  final controller = GroupButtonController();

  String selectedGender = "";
  String errorMessage = "Please select which genders you would like to date.";

  @override
  void initState() {
    if (widget.currentUser.getGenderPreference.isNotEmpty) {
      selectedGender = widget.currentUser.getGenderPreference;
      if (selectedGender == "Men") {
        controller.selectIndex(0);
      } else if (selectedGender == "Women") {
        controller.selectIndex(1);
      } else {
        controller.selectIndex(2);
      }
    }
    super.initState();
  }

  String getErrorMessage() {
    return errorMessage;
  }

  bool validateGenderPreference() {
    if (selectedGender.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void updateUserGenderPreference() {
    widget.currentUser.setGenderPreference = selectedGender;
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
                  "Who do you want to date?",
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
                    buttons: const ["Men", "Women", "Everyone"],
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
