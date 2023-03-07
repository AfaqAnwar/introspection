import 'package:datingapp/pages/registration/register_page_host.dart';
import 'package:datingapp/pages/signin_signup/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class RegisterBuffer extends StatefulWidget {
  const RegisterBuffer({super.key});

  @override
  State<RegisterBuffer> createState() => RegisterBufferState();
}

class RegisterBufferState extends State<RegisterBuffer>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool animationEnded = false;
  late final Future<LottieComposition> _composition;

  @override
  void initState() {
    super.initState();
    _composition = _loadComposition();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<LottieComposition> _loadComposition() async {
    var assetData = await rootBundle.load('assets/animations/buffer.json');
    return await LottieComposition.fromByteData(assetData);
  }

  void continueToRegister() {
    Navigator.push(
        context,
        PageTransition(
            child: const RegisterPageHost(),
            childCurrent: const RegisterBuffer(),
            type: PageTransitionType.rightToLeftPop));
  }

  void goBackToLogin() {
    Navigator.push(
        context,
        PageTransition(
            child: const LoginPage(),
            childCurrent: const RegisterBuffer(),
            type: PageTransitionType.leftToRightPop));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LottieComposition>(
      future: _composition,
      builder: (context, snapshot) {
        var composition = snapshot.data;
        if (composition != null) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      "Let's get to know more about you!",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 42,
                        fontFamily: 'Modern-Era',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  const Padding(
                    padding: EdgeInsets.only(left: 40),
                    child: Text(
                      "Adding basic info leads to better matches!",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontFamily: 'Modern-Era',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  SizedBox(
                    height: 350,
                    child: Lottie(
                      repeat: true,
                      composition: composition,
                      controller: _controller,
                      fit: BoxFit.fill,
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
