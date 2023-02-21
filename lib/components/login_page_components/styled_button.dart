import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  final Function()? onTap;
  final Color buttonColor;
  final String buttonText;

  const StyledButton(
      {super.key,
      required this.onTap,
      required this.buttonColor,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
          buttonText,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        )),
      ),
    );
  }
}
