import 'package:datingapp/style/app_style.dart';

import 'package:flutter/material.dart';

class RegistrationNavigationButton extends StatelessWidget {
  final Function() updateIndexFunction;
  final Function()? secondaryFunction;
  const RegistrationNavigationButton(
      {super.key, required this.updateIndexFunction, this.secondaryFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: IconButton(
        icon: const Icon(
          Icons.arrow_circle_right,
        ),
        color: AppStyle.red800,
        iconSize: 48,
        splashRadius: 0.1,
        onPressed: () {
          if (secondaryFunction != null) {
            if (secondaryFunction!() == true) {
              updateIndexFunction();
            }
          }
        },
      ),
    );
  }
}
