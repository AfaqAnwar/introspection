import 'package:datingapp/components/registration_components/registration_textfield.dart';
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
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
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
      ],
    );
  }
}
