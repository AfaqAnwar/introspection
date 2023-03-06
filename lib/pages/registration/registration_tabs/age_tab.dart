import 'package:datingapp/data/user.dart';
import 'package:datingapp/pages/registration/register_page_host.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgeTab extends StatefulWidget {
  final User currentUser;
  final Function() updateIndex;
  const AgeTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<AgeTab> createState() => AgeTabState();
}

class AgeTabState extends State<AgeTab> {
  late int age;
  late String dob;
  late DateTime selectedDob;
  bool confirmed = false;

  @override
  void initState() {
    if (widget.currentUser.getDob.isNotEmpty) {
      age = DateTime.now().year -
          int.parse(widget.currentUser.getDob.split("-")[2]);
      List<String> splitDob = widget.currentUser.getDob.split("-");
      String userDob = "${splitDob[2]}-${splitDob[0]}-${splitDob[1]}";
      selectedDob = DateTime.parse(userDob);
    } else {
      age = 0;
      selectedDob = DateTime.now().subtract(const Duration(hours: 1));
    }
    super.initState();
  }

  String getDobProper(DateTime selectedDate) {
    String finalDob = selectedDate.toString();
    finalDob = finalDob.split(" ")[0];
    List splitDob = finalDob.split("-");
    String year = splitDob[0];
    String month = splitDob[1];
    String day = splitDob[2];
    finalDob = "$month-$day-$year";
    return finalDob;
  }

  void updateAgeOnUI(DateTime selectedDate) {
    setState(() {
      age = DateTime.now().year - selectedDate.year;
    });
  }

  bool validateAge() {
    if (age < 18) {
      return false;
    } else {
      return true;
    }
  }

  void updateUserDob() {
    if (validateAge() == true) {
      widget.currentUser.setDob = getDobProper(selectedDob);
    }
  }

  String getErrorMessage() {
    return "You must be at least 18 years old to use this app.";
  }

  bool isConfirmed() {
    return confirmed;
  }

  Future<bool> showConfirmation() async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: const Text(
                "Please confirm your information",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Marlide-Display',
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text("$age years old.",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontFamily: 'Modern-Era',
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(height: 5),
                  Text("Born ${getDobProper(selectedDob)}",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontFamily: 'Modern-Era',
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
              actions: [
                CupertinoDialogAction(
                  child: const Text(
                    "Edit",
                    style: TextStyle(
                        fontFamily: 'Modern-Era',
                        fontWeight: FontWeight.w100,
                        color: Colors.black),
                  ),
                  onPressed: () {
                    confirmed = false;
                    Navigator.pop(context, false);
                  },
                ),
                CupertinoDialogAction(
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                        fontFamily: 'Modern-Era',
                        fontWeight: FontWeight.w500,
                        color: AppStyle.red700),
                  ),
                  onPressed: () {
                    confirmed = true;
                    Navigator.pop(context, true);
                  },
                ),
              ],
            ));
    return confirmed;
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
                "When's your birthday?",
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
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: CupertinoDatePicker(
                initialDateTime: selectedDob,
                maximumDate: DateTime.now(),
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime date) {
                  updateAgeOnUI(date);
                  selectedDob = date;
                }),
          ),
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width - 80,
            child: Divider(
              thickness: 0.5,
              color: Colors.grey[400],
            )),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Age ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontFamily: 'Modern-Era',
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              age.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontFamily: 'Modern-Era',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "This can't be changed later",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
            fontFamily: 'Modern-Era',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
