import 'package:datingapp/components/login_page_components/login_textfield.dart';
import 'package:datingapp/components/login_page_components/login_tile.dart';
import 'package:datingapp/components/login_page_components/login_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Icon(
                CupertinoIcons.heart,
                size: 100,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "Welcome back! You've been missed!",
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
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
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text("Forgot Password?",
                      style: TextStyle(color: Colors.grey[600]))
                ]),
              ),
              const SizedBox(
                height: 25,
              ),
              SignInButton(
                onTap: signUserIn,
              ),
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
                children: const [
                  LoginTile(imagePath: "assets/images/apple.png"),
                  SizedBox(
                    width: 25,
                  ),
                  LoginTile(imagePath: "assets/images/google.png")
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Not a member?"),
                  SizedBox(width: 4),
                  Text(
                    "Register Now!",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
