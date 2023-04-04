import 'package:flutter/material.dart';

class PasswordButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;

  const PasswordButton(
      {super.key, required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
          buttonText,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        )),
      ),
    );
  }
}
