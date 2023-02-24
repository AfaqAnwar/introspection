import 'package:datingapp/pages/registration/registration_tabs/name_tab.dart';
import 'package:datingapp/pages/signin_signup/login_page.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:page_transition/page_transition.dart';
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

  void updateIndexBackwards() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            splashRadius: 0.1,
            color: AppStyle.red800,
            onPressed: () {
              if (currentIndex == 0) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          title: const Text('Woah There!'),
                          content: const Text("Are you sure you want to exit?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Cancel",
                                  style: TextStyle(color: AppStyle.red400)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: const LoginPage(),
                                        childCurrent: const RegisterPageHost(),
                                        type:
                                            PageTransitionType.leftToRightPop));
                              },
                              child: Text(
                                "Yes Take Me Back!",
                                style: TextStyle(color: AppStyle.red800),
                              ),
                            )
                          ],
                        ));
              }
              updateIndexBackwards();
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(children: [
            DotStepper(
              tappingEnabled: false,
              dotCount: totalIndex,
              dotRadius: 6,
              activeStep: currentIndex,
              shape: Shape.circle,
              spacing: 10,
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
