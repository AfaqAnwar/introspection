import 'package:Introspection/data/custom_user.dart';
import 'package:Introspection/pages/registration/registration_tabs/information_tab.dart';
import 'package:Introspection/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class DrugPreferenceTab extends StatefulWidget {
  final CustomUser currentUser;
  final Function() updateIndex;
  const DrugPreferenceTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<DrugPreferenceTab> createState() => DrugPreferenceTabState();
}

class DrugPreferenceTabState extends State<DrugPreferenceTab>
    with InformationTab {
  final controller = GroupButtonController();

  String drugPreference = "";
  String errorMessage = "Please tell us if you do drugs.";

  @override
  void initState() {
    if (widget.currentUser.getDrugPreference.isNotEmpty) {
      drugPreference = widget.currentUser.getDrugPreference;
      if (drugPreference == "Yes") {
        controller.selectIndex(0);
      } else if (drugPreference == "Sometimes") {
        controller.selectIndex(1);
      } else if (drugPreference == "No") {
        controller.selectIndex(2);
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
    if (drugPreference.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void updateUserInformation() {
    widget.currentUser.setDrugPreference = drugPreference;
  }

  @override
  String toStringShort() {
    return errorMessage;
  }

  @override
  bool hasChanged() {
    return drugPreference != widget.currentUser.getDrugPreference;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  "Do you use drugs?",
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
                        drugPreference = value;
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
