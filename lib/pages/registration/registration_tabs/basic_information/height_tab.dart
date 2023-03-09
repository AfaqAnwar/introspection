import 'package:datingapp/components/registration_components/cupertino_picker_object.dart';
import 'package:datingapp/data/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeightTab extends StatefulWidget {
  final User currentUser;
  final Function() updateIndex;
  const HeightTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<HeightTab> createState() => HeightTabState();
}

class HeightTabState extends State<HeightTab> {
  List<CupertinoPickerObject> heights = [];
  String errorMessage = "Please select which genders you would like to date.";
  String selectedHeight = "";

  @override
  void initState() {
    buildHeights();
    super.initState();
  }

  void buildHeights() {
    for (int i = 4; i < 8; i++) {
      for (int j = 0; j < 12; j++) {
        int heightInCentimeters = ((i * 12 + j) * 2.54).floor();
        // ignore: prefer_interpolation_to_compose_strings
        String height = i.toString() +
            "' " +
            j.toString() +
            ' (' +
            heightInCentimeters.toString() +
            ' cm)';

        heights.add(CupertinoPickerObject(objectText: height));
      }
    }
  }

  void updateUserHeight() {
    widget.currentUser.setHeight = selectedHeight;
  }

  String getErrorMessage() {
    return errorMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "How tall are you?",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontFamily: 'Marlide-Display',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: CupertinoPicker(
              itemExtent: 40,
              backgroundColor: Colors.white,
              onSelectedItemChanged: (int value) {
                selectedHeight = heights[value].getObjectText().split("(")[0];
              },
              children: heights,
            ),
          ),
        ),
      ],
    );
  }
}
