import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class BasicInformationBuffer extends StatefulWidget {
  final Function() onContinue;
  const BasicInformationBuffer({super.key, required this.onContinue});

  @override
  State<BasicInformationBuffer> createState() => BasicInformationBufferState();
}

class BasicInformationBufferState extends State<BasicInformationBuffer>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool animationEnded = false;
  late final Future<LottieComposition> _composition;

  @override
  void initState() {
    super.initState();
    _composition = _loadComposition();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<LottieComposition> _loadComposition() async {
    var assetData =
        await rootBundle.load('assets/animations/basic_info_buffer.json');
    return await LottieComposition.fromByteData(assetData);
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
                        "Profiles with personality get more matches!",
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
                        "Be sure to show off your best side!",
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
                    onTap: widget.onContinue,
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
