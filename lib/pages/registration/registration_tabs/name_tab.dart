import 'package:datingapp/components/registration_components/registration_navigation_button.dart';
import 'package:datingapp/components/registration_components/registration_textfield.dart';
import 'package:datingapp/data/user.dart';
import 'package:flutter/material.dart';

class NameTab extends StatefulWidget {
  final User currentUser;
  final Function() updateIndex;
  const NameTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<NameTab> createState() => _NameTabState();
}

class _NameTabState extends State<NameTab> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "What's Your Name?",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontFamily: 'Marlide-Display',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        RegistrationTextField(
            controller: firstNameController,
            hintText: "First Name",
            obscureText: false),
        const SizedBox(height: 50),
        RegistrationTextField(
            controller: lastNameController,
            hintText: "Last Name (optional)",
            obscureText: false),
        const SizedBox(height: 200),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          RegistrationNavigationButton(
              updateIndexFunction: widget.updateIndex,
              secondaryFunction: () {
                widget.currentUser.setFirstName = firstNameController.text;
                widget.currentUser.setLastName = lastNameController.text;
              })
        ]),
      ],
    );
  }
}
