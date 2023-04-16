import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:datingapp/components/registration_authentication_components/password_button.dart';
import 'package:datingapp/components/registration_authentication_components/password_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Reauth {
  late TextEditingController currentPasswordController;
  late bool reauthFailed;
  late Flushbar flushbar;

  Reauth() {
    currentPasswordController = TextEditingController();
    reauthFailed = false;
    initializeFlushbar();
  }

  void initializeFlushbar() {
    flushbar = Flushbar(
      flushbarStyle: FlushbarStyle.GROUNDED,
      messageText: const Text("Incorrect Password",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          )),
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  void dispose() {
    currentPasswordController.dispose();
  }

  bool isCurrentPasswordPresent() {
    if (currentPasswordController.text.trim().isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future reauth() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: FirebaseAuth.instance.currentUser!.email.toString(),
        password: currentPasswordController.text.trim(),
      );
      reauthFailed = false;
      return true;
    } catch (e) {
      reauthFailed = true;
      return false;
    }
  }

  bool didReauthFail() {
    return reauthFailed;
  }

  void showErrorMessage(BuildContext context) {
    if (!flushbar.isShowing()) {
      flushbar.show(context);
    }
  }

  Future<dynamic> buildPopUp(BuildContext originalContext) {
    return showDialog(
        barrierDismissible: true,
        context: originalContext,
        builder: (newContext) {
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
                      controller: currentPasswordController,
                      hintText: "Confirm Current Password",
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                PasswordButton(
                    onTap: () async {
                      await reauth().then((value) => {
                            if (value == true)
                              {
                                Navigator.of(originalContext).pop(),
                              }
                            else
                              {
                                showErrorMessage(newContext),
                              }
                          });
                    },
                    buttonText: "Confirm Password"),
                const SizedBox(height: 20),
              ],
            ),
          );
        });
  }
}
