import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:datingapp/components/login_page_components/login_textfield.dart';
import 'package:datingapp/components/login_page_components/styled_button.dart';
import 'package:datingapp/components/registration_components/password_button.dart';
import 'package:datingapp/components/registration_components/password_textfield.dart';
import 'package:datingapp/components/registration_components/registration_textfield.dart';
import 'package:datingapp/data/current_user.dart';
import 'package:datingapp/helpers/firebase_registration.dart';
import 'package:datingapp/pages/home_page_host.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class FinalizationBuffer extends StatefulWidget {
  final CurrentUser currentUser;
  const FinalizationBuffer({super.key, required this.currentUser});

  @override
  State<FinalizationBuffer> createState() => FinalizationBufferState();
}

class FinalizationBufferState extends State<FinalizationBuffer>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool animationEnded = false;
  late final Future<LottieComposition> _composition;
  late final AnimationController progressController;

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  late Flushbar progressBar;

  @override
  void initState() {
    super.initState();
    _composition = _loadComposition();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    progressController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    progressBar = Flushbar(
      isDismissible: true,
      messageText: const Text("Loading...",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          )),
      flushbarStyle: FlushbarStyle.GROUNDED,
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: Colors.white,
      progressIndicatorValueColor:
          AlwaysStoppedAnimation<Color>(AppStyle.red500),
      backgroundColor: Colors.white,
      progressIndicatorController: progressController,
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<LottieComposition> _loadComposition() async {
    var assetData = await rootBundle.load('assets/animations/final-load.json');
    return await LottieComposition.fromByteData(assetData);
  }

  bool confirmPassword() {
    if (passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Flushbar(
        flushbarStyle: FlushbarStyle.GROUNDED,
        messageText: const Text("Please fill in all fields",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            )),
        backgroundColor: Colors.white,
        duration: const Duration(seconds: 2),
      ).show(context);
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      Flushbar(
        flushbarStyle: FlushbarStyle.GROUNDED,
        messageText: const Text("Passwords do not match",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            )),
        backgroundColor: Colors.white,
        duration: const Duration(seconds: 2),
      ).show(context);
      return false;
    }

    if (passwordController.text == confirmPasswordController.text) {
      return true;
    }

    return false;
  }

  void showProgressIndicator() {
    progressBar.show(context);
    progressController.repeat();
  }

  void dismissProgressIndicator() {
    progressController.stop();
    progressBar.dismiss();
  }

  void showErrorIndicator(String error) {
    Flushbar(
      flushbarStyle: FlushbarStyle.GROUNDED,
      messageText: Text("Error: $error",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          )),
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  Future registerUser() async {
    showProgressIndicator();
    FirebaseRegistrationHelper helper =
        FirebaseRegistrationHelper(widget.currentUser);

    await helper
        .registerUser(passwordController.text.trim())
        .then((value) async {
      if (value == "Success") {
        await helper.addUserDetails();
        dismissProgressIndicator();
        Future.delayed(const Duration(milliseconds: 100), () {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: const HomePageHost(),
                  type: PageTransitionType.rightToLeft));
        });
      } else {
        dismissProgressIndicator();
        showErrorIndicator(value);
      }
    });
  }

  void showPasswordDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AlertDialog(
              shape: ShapeBorder.lerp(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  1)!,
              backgroundColor: Colors.grey.shade200.withOpacity(0.5),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    const SizedBox(height: 10),
                    PasswordTextField(
                      controller: passwordController,
                      hintText: "Password",
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                    PasswordTextField(
                      controller: confirmPasswordController,
                      hintText: "Confirm Password",
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                PasswordButton(
                    onTap: () async {
                      if (confirmPassword() == true) {
                        await registerUser();
                        print("Registered");
                      }
                    },
                    buttonText: "Confirm Password"),
                const SizedBox(height: 20),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LottieComposition>(
      future: _composition,
      builder: (context, snapshot) {
        var composition = snapshot.data;
        if (composition != null) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(children: const [
                    Padding(
                      padding: EdgeInsets.all(25),
                      child: Text(
                        "Let's get started!",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 42,
                          fontFamily: 'Modern-Era',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(children: const [
                    Padding(
                      padding: EdgeInsets.all(25),
                      child: Text(
                        "Thoughtful answers get more matches!",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 38,
                          fontFamily: 'Modern-Era',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ]),
                ),
                Lottie(
                  width: 400,
                  height: 400,
                  repeat: true,
                  composition: composition,
                  controller: _controller,
                  fit: BoxFit.fill,
                ),
                Expanded(
                  child: Container(),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      showPasswordDialog();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(35),
                      decoration: BoxDecoration(
                        color: AppStyle.red800,
                      ),
                      child: const Center(
                          child: Text(
                        "Create Your Profile",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                    ),
                  ),
                ),
              ]);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
