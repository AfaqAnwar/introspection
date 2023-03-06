import 'package:datingapp/pages/registration/registration_tabs/age_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/email_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/name_tab.dart';
import 'package:datingapp/pages/signin_signup/login_page.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:page_transition/page_transition.dart';
import '../../data/user.dart';

class RegisterPageHost extends StatefulWidget {
  const RegisterPageHost({super.key});

  @override
  State<RegisterPageHost> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPageHost> {
  late User user;
  int currentIndex = 0;
  int totalIndex = 4;
  final GlobalKey<NameTabState> _nameTabKey = GlobalKey();
  final GlobalKey<EmailTabState> _emailTabKey = GlobalKey();
  final GlobalKey<AgeTabState> _ageTabKey = GlobalKey();
  String errorMessage = "";

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

  Future<bool> checkFieldsAndUpdateCurrentUser() async {
    switch (currentIndex) {
      case 0:
        _nameTabKey.currentState!.updateNameOfUser();
        return _nameTabKey.currentState!.textFieldValidation();
      case 1:
        _emailTabKey.currentState!.updateUserEmail();
        return _emailTabKey.currentState!.emailTextValidation();
      case 2:
        _ageTabKey.currentState!.reset();
        bool changeScreen = false;
        if (_ageTabKey.currentState?.validateAge() == true) {
          _ageTabKey.currentState!.updateUserDob();
          changeScreen = await _ageTabKey.currentState!.showConfirmation();
        }
        return changeScreen;
      default:
        return false;
    }
  }

  void destroyData() {
    switch (currentIndex) {
      case 0:
        user.setFirstName = "";
        user.setLastName = "";
        break;
      case 1:
        user.setEmail = "";
        break;
      case 2:
        user.setDob = "";
        break;
      case 3:
        break;
      default:
        break;
    }
  }

  void updateErrorMessage() {
    switch (currentIndex) {
      case 0:
        errorMessage = _nameTabKey.currentState!.getErrorMessage();
        break;
      case 1:
        errorMessage = _emailTabKey.currentState!.getErrorMessage();
        break;
      case 2:
        errorMessage = _ageTabKey.currentState!.getErrorMessage();
        break;
      default:
        break;
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
            onPressed: () async {
              destroyData();
              if (currentIndex == 0) {
                showDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                          title: const Text(
                            'Woah There!',
                            style: TextStyle(fontSize: 18),
                          ),
                          content: Column(
                            children: const [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Are you sure you want to exit?",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: SafeArea(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: IconButton(
                alignment: Alignment.bottomRight,
                icon: const Icon(Icons.arrow_forward_ios),
                color: AppStyle.red800,
                iconSize: 28,
                splashRadius: 0.01,
                onPressed: () async {
                  if (await checkFieldsAndUpdateCurrentUser()) {
                    updateIndex();
                  } else if ((currentIndex == 2 &&
                          _ageTabKey.currentState?.isConfirmed() == false &&
                          !_ageTabKey.currentState!.isEditing()) ||
                      currentIndex != 2) {
                    updateErrorMessage();
                    // ignore: use_build_context_synchronously
                    showDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                              title: const Text(
                                'Whoops!',
                                style: TextStyle(fontSize: 18),
                              ),
                              content: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    errorMessage.toString(),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    "Okay",
                                    style: TextStyle(color: AppStyle.red800),
                                  ),
                                )
                              ],
                            ));
                  }
                },
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            child: SafeArea(
              child: Column(children: [
                const SizedBox(height: 10),
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
                const SizedBox(height: 80),
                updateBodyContent(),
              ]),
            ),
          ),
        ));
  }

  Widget updateBodyContent() {
    switch (currentIndex) {
      case 0:
        return NameTab(
          key: _nameTabKey,
          currentUser: user,
          updateIndex: updateIndex,
        );
      case 1:
        return EmailTab(
            key: _emailTabKey, currentUser: user, updateIndex: updateIndex);
      case 2:
        return AgeTab(
            key: _ageTabKey, currentUser: user, updateIndex: updateIndex);
      case 3:
        return const Text('Register Page');
      default:
        return const Text('Register Page');
    }
  }
}
