import 'package:datingapp/components/login_page_components/styled_button.dart';
import 'package:datingapp/pages/registration/register_page_.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late final Future<LottieComposition> _composition;

  @override
  void initState() {
    super.initState();
    _composition = _loadComposition();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                animationEnded = true;
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

  Future<LottieComposition> _loadComposition() async {
    var assetData = await rootBundle.load('assets/animations/love.json');
    return await LottieComposition.fromByteData(assetData);
  }

  void continueToRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LottieComposition>(
      future: _composition,
      builder: (context, snapshot) {
        var composition = snapshot.data;
        if (composition != null) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome To Introspection",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppStyle.red800,
                          fontSize: 48,
                          fontFamily: 'Charter',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Lottie(
                        composition: composition,
                        controller: _controller,
                        width: 250,
                        height: 250,
                        fit: BoxFit.fill,
                      ),
                      StyledButton(
                          onTap: continueToRegister,
                          buttonColor: AppStyle.red800,
                          buttonText: "Let's Get Started!")
                    ]),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
