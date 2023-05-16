import 'package:Introspection/data/custom_user.dart';
import 'package:Introspection/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class EthnicityTab extends StatefulWidget {
  final CustomUser currentUser;
  final Function() updateIndex;
  const EthnicityTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<EthnicityTab> createState() => EthnicityTabState();
}

class EthnicityTabState extends State<EthnicityTab> {
  final controller = GroupButtonController();
  List<String> selectedEthnicities = [];

  String errorMessage = "Please select at least one ethnicity.";

  @override
  void initState() {
    if (widget.currentUser.getEthnicities.isNotEmpty) {
      selectedEthnicities = widget.currentUser.getEthnicities;
      List<int> indexes = getIndexesOfEthnicities(selectedEthnicities);
      if (indexes.isNotEmpty) {
        for (int i = 0; i < indexes.length; i++) {
          controller.selectIndex(indexes[i]);
        }
      }
    }
    super.initState();
  }

  String getErrorMessage() {
    return errorMessage;
  }

  @override
  String toStringShort() {
    return errorMessage;
  }

  bool validateEthnicities() {
    if (selectedEthnicities.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void updateUserEthnicities() {
    widget.currentUser.setEthnicities = selectedEthnicities;
  }

  List<int> getIndexesOfEthnicities(List<String> ethnicities) {
    if (ethnicities.isEmpty) {
      return [];
    }
    List<int> ethnicitiesIndexes = [];
    for (int i = 0; i < ethnicities.length; i++) {
      switch (ethnicities[i]) {
        case "American Indian":
          ethnicitiesIndexes.add(0);
          break;
        case "Black/African Descent":
          ethnicitiesIndexes.add(1);
          break;
        case "East Asian":
          ethnicitiesIndexes.add(2);
          break;
        case "Hispanic/Latino":
          ethnicitiesIndexes.add(3);
          break;
        case "Middle Eastern":
          ethnicitiesIndexes.add(4);
          break;
        case "Native Hawaiian/Pacific Islander":
          ethnicitiesIndexes.add(5);
          break;
        case "South Asian":
          ethnicitiesIndexes.add(6);
          break;
        case "White/Caucasian":
          ethnicitiesIndexes.add(7);
          break;
        case "Other":
          ethnicitiesIndexes.add(8);
          break;
      }
    }
    return ethnicitiesIndexes;
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
                  "What's your ethnicity?",
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
          alignment: Alignment.topLeft,
          child: Wrap(
            alignment: WrapAlignment.start,
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
                    maxSelected: 9,
                    enableDeselect: true,
                    isRadio: false,
                    onSelected: (value, index, isSelected) {
                      if (!isSelected &&
                          selectedEthnicities.contains(value.toString())) {
                        selectedEthnicities.remove(value.toString());
                      }
                      if (isSelected &&
                          !selectedEthnicities.contains(value.toString())) {
                        selectedEthnicities.add(value.toString());
                      }
                    },
                    buttons: const [
                      "American Indian",
                      "Black/African Descent",
                      "East Asian",
                      "Hispanic/Latino",
                      "Middle Eastern",
                      "Native Hawaiian/Pacific Islander",
                      "South Asian",
                      "White/Caucasian",
                      "Other"
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
