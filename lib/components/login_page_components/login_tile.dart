import 'package:flutter/material.dart';

class LoginTile extends StatelessWidget {
  final String imagePath;
  final Color backgroundColor;
  final Color iconColor;

  const LoginTile(
      {super.key,
      required this.imagePath,
      required this.backgroundColor,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: backgroundColor),
      child: Image.asset(imagePath, height: 40, color: iconColor),
    );
  }
}
