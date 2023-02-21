import 'package:datingapp/components/login_page_components/login_textfield.dart';
import 'package:datingapp/components/login_page_components/login_tile.dart';
import 'package:datingapp/components/login_page_components/login_button.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool checkFields() {
    if (emailController.text.trim().toString().isEmpty ||
        passwordController.text.trim().toString().isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void signUserIn() async {
    if (checkFields() == false) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                title: const Text('Login Input Error'),
                content: const Text(
                    'Please fill out both your email & password before attempting to sign in.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Okay",
                    ),
                  )
                ],
              ));
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        String errorMessage = "";
        switch (e.code) {
          case "invalid-email":
            errorMessage = "You entered an invalid email address.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests. Try again later.";
            break;
          case "operation-now-alllowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  title: const Text('Login Error'),
                  content: Text(errorMessage.toString()),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Okay",
                      ),
                    )
                  ],
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Icon(
                  CupertinoIcons.heart,
                  size: 100,
                  color: AppStyle.red700,
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Welcome back! You've been missed!",
                  style: TextStyle(color: AppStyle.red800, fontSize: 16),
                ),
                const SizedBox(
                  height: 25,
                ),
                LoginTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                LoginTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Forgot Password?",
                            style: TextStyle(color: AppStyle.red600))
                      ]),
                ),
                const SizedBox(
                  height: 25,
                ),
                SignInButton(onTap: signUserIn, buttonColor: AppStyle.red900),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Or continue with",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoginTile(
                      imagePath: "assets/images/apple.png",
                      backgroundColor: AppStyle.red900,
                      iconColor: Colors.white,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    LoginTile(
                      imagePath: "assets/images/google.png",
                      backgroundColor: AppStyle.red900,
                      iconColor: Colors.white,
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a member?"),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register Now!",
                        style: TextStyle(
                            color: AppStyle.red200,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
