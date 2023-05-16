import 'package:Introspection/pages/registration/register_page_host.dart';
import 'package:Introspection/pages/signin_signup/login_page.dart';
import 'package:Introspection/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class RegisterLoad extends StatefulWidget {
  const RegisterLoad({super.key});

  @override
  State<RegisterLoad> createState() => _RegisterLoadState();
}

class _RegisterLoadState extends State<RegisterLoad>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool animationEnded = false;
  late final Future<LottieComposition> _composition;

  @override
  void initState() {
    super.initState();
    _composition = _loadComposition();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
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
    var assetData = await rootBundle.load('assets/animations/loveglass.json');
    return await LottieComposition.fromByteData(assetData);
  }

  void continueToRegister() {
    Navigator.push(
        context,
        PageTransition(
            child: const RegisterPageHost(),
            childCurrent: const RegisterLoad(),
            type: PageTransitionType.rightToLeftPop));
  }

  void goBackToLogin() {
    Navigator.push(
        context,
        PageTransition(
            child: const LoginPage(),
            childCurrent: const RegisterLoad(),
            type: PageTransitionType.leftToRightPop));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LottieComposition>(
      future: _composition,
      builder: (context, snapshot) {
        var composition = snapshot.data;
        if (composition != null) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                splashRadius: 0.1,
                color: AppStyle.red800,
                onPressed: goBackToLogin,
              ),
            ),
            backgroundColor: Colors.white,
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Container()),
                  SafeArea(
                    child: Wrap(children: [
                      Center(
                        child: Text(
                          "Welcome To Introspection",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppStyle.red800,
                            fontSize: 64,
                            fontFamily: 'Marlide-Display',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Center(
                    child: Lottie(
                      composition: composition,
                      controller: _controller,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Expanded(child: Container()),
                  Center(
                    child: GestureDetector(
                      onTap: continueToRegister,
                      child: Container(
                        padding: const EdgeInsets.all(35),
                        decoration: BoxDecoration(
                          color: AppStyle.red800,
                        ),
                        child: const Center(
                            child: Text(
                          "Let's Gets Started!",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                      ),
                    ),
                  ),
                ]),
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
