import 'package:datingapp/pages/registration/registration_tabs/name_tab.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import '../../data/user.dart';

class RegisterPageHost extends StatefulWidget {
  const RegisterPageHost({super.key});

  @override
  State<RegisterPageHost> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPageHost> {
  late User user;
  int currentIndex = 0;
  int totalIndex = 2;

  @override
  void initState() {
    super.initState();
    user = User();
  }

  void updateIndex() {
    if (currentIndex < totalIndex - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(children: [
            DotStepper(
              tappingEnabled: false,
              dotCount: totalIndex,
              dotRadius: 8,
              activeStep: currentIndex,
              shape: Shape.circle,
              spacing: 12,
              indicator: Indicator.shift,
              fixedDotDecoration: FixedDotDecoration(
                  color: Colors.grey.shade400,
                  strokeColor: Colors.grey.shade400,
                  strokeWidth: 1),
              indicatorDecoration: IndicatorDecoration(
                  color: AppStyle.red500,
                  strokeColor: AppStyle.red500,
                  strokeWidth: 1),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: Container(),
            ),
            updateBodyContent(),
            const SizedBox(height: 100),
            Expanded(
              child: Container(),
            ),
            const SizedBox(height: 50)
          ]),
        ));
  }

  Widget updateBodyContent() {
    switch (currentIndex) {
      case 0:
        return NameTab(
          currentUser: user,
          updateIndex: updateIndex,
        );
      case 1:
        return const Text('Register Page');
      case 2:
        return const Text('Register Page');
      default:
        return const Text('Register Page');
    }
  }
}
