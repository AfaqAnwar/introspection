import 'package:datingapp/data/user.dart';
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
  String errorMessage = "";

  @override
  void initState() {
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
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime date) {
                  updateAgeOnUI(date);
                  print(getDobProper(date));
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
