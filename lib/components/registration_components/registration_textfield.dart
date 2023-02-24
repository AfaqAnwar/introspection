import 'package:flutter/material.dart';

class RegistrationTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;

  const RegistrationTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 18),
            enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.grey.shade600, width: 1.5)),
            focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.grey.shade900, width: 2.5))),
      ),
    );
  }
}
