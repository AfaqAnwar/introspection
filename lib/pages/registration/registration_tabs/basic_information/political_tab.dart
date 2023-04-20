import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/pages/registration/registration_tabs/information_tab.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class PoliticalBeliefTab extends StatefulWidget {
  final CustomUser currentUser;
  final Function() updateIndex;
  const PoliticalBeliefTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<PoliticalBeliefTab> createState() => PoliticalBeliefTabState();
}

class PoliticalBeliefTabState extends State<PoliticalBeliefTab>
    with InformationTab {
  final controller = GroupButtonController();

  String selectedPoliticalBelief = "";
  String errorMessage = "Please select your political belief, if any.";

  @override
  void initState() {
    if (widget.currentUser.getPoliticalBelief.isNotEmpty) {
      selectedPoliticalBelief = widget.currentUser.getPoliticalBelief;
      if (selectedPoliticalBelief == "Liberal") {
        controller.selectIndex(0);
      } else if (selectedPoliticalBelief == "Moderate") {
        controller.selectIndex(1);
      } else if (selectedPoliticalBelief == "Conservative") {
        controller.selectIndex(2);
      } else if (selectedPoliticalBelief == "Other") {
        controller.selectIndex(3);
      } else if (selectedPoliticalBelief == "None") {
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
    if (selectedPoliticalBelief.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void updateUserInformation() {
    widget.currentUser.setPoliticalBelief = selectedPoliticalBelief;
  }

  @override
  String toStringShort() {
    return errorMessage;
  }

  @override
  bool hasChanged() {
    return selectedPoliticalBelief != widget.currentUser.getPoliticalBelief;
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
                  "What are your political beliefs?",
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
                        selectedPoliticalBelief = value;
                      }
                    },
                    buttons: const [
                      "Liberal",
                      "Moderate",
                      "Conservative",
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
