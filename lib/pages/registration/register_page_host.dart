import 'package:datingapp/pages/registration/registration_tabs/name_tab.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';

class RegisterPageHost extends StatefulWidget {
  const RegisterPageHost({super.key});

  @override
  State<RegisterPageHost> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPageHost> {
  int currentIndex = 0;
  int totalIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(children: [
            DotStepper(
              dotCount: totalIndex,
              dotRadius: 8,
              activeStep: currentIndex,
              shape: Shape.circle,
              spacing: 12,
              indicator: Indicator.shift,
              onDotTapped: (tappedDotIndex) {
                setState(() {
                  currentIndex = tappedDotIndex;
                });
              },
              fixedDotDecoration: FixedDotDecoration(
                  color: Colors.grey.shade400,
                  strokeColor: Colors.grey.shade400,
                  strokeWidth: 1),
              indicatorDecoration: IndicatorDecoration(
                  color: AppStyle.red500,
                  strokeColor: AppStyle.red500,
                  strokeWidth: 1),
            ),
            Expanded(
              child: Container(),
            ),
            updateBodyContent(),
            const SizedBox(height: 200),
            Expanded(
              child: Container(),
            ),
            // Icon button that is aligned to the right that navigates to next tab.
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_circle_right,
                  ),
                  color: AppStyle.red800,
                  iconSize: 48,
                  splashRadius: 0.1,
                  onPressed: () {
                    if (currentIndex < totalIndex - 1) {
                      setState(() {
                        currentIndex++;
                      });
                    }
                  },
                ),
              ),
            ]),
            const SizedBox(height: 50)
          ]),
        ));
  }

  Widget updateBodyContent() {
    switch (currentIndex) {
      case 0:
        return const NameTab();
      case 1:
        return const Text('Register Page');
      case 2:
        return const Text('Register Page');
      default:
        return const Text('Register Page');
    }
  }
}
