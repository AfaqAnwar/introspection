import 'package:datingapp/pages/registration/register_page_.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegisterLoad extends StatefulWidget {
  const RegisterLoad({super.key});

  @override
  State<RegisterLoad> createState() => _RegisterLoadState();
}

class _RegisterLoadState extends State<RegisterLoad>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool animationEnded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            animationEnded = true;
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RegisterPage()));
          });
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.network(
                      'https://assets10.lottiefiles.com/packages/lf20_Tj3A1GrIHf.json',
                      controller: _controller),
                ]),
          ),
        ));
  }
}
