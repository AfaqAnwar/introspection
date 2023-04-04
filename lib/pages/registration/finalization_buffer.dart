import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:datingapp/components/login_page_components/login_textfield.dart';
import 'package:datingapp/components/login_page_components/styled_button.dart';
import 'package:datingapp/components/registration_components/password_button.dart';
import 'package:datingapp/components/registration_components/password_textfield.dart';
import 'package:datingapp/components/registration_components/registration_textfield.dart';
import 'package:datingapp/data/user.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class FinalizationBuffer extends StatefulWidget {
  final User currentUser;
  const FinalizationBuffer({super.key, required this.currentUser});

  @override
  State<FinalizationBuffer> createState() => FinalizationBufferState();
}

class FinalizationBufferState extends State<FinalizationBuffer>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool animationEnded = false;
  late final Future<LottieComposition> _composition;

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _composition = _loadComposition();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

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

  void confirmPassword() {
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
    }

    if (passwordController.text == confirmPasswordController.text) {}
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
                    onTap: confirmPassword, buttonText: "Confirm Password"),
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
