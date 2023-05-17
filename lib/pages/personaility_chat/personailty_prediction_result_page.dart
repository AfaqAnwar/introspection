import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/helpers/firebase_manager.dart';
import 'package:datingapp/helpers/firebase_updater.dart';
import 'package:datingapp/helpers/personality_classifier.dart';
import 'package:datingapp/pages/future_home_buffer_builder.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';

class PersonailtyPredictionResultPage extends StatefulWidget {
  final CustomUser currentUser;
  const PersonailtyPredictionResultPage(
      {super.key,
      required this.userQuestionareResults,
      required this.currentUser});

  @override
  State<PersonailtyPredictionResultPage> createState() =>
      _PersonailtyPredictionResultPage();

  final String userQuestionareResults;
}

class _PersonailtyPredictionResultPage
    extends State<PersonailtyPredictionResultPage>
    with TickerProviderStateMixin {
  late int statusCode;
  late String finalResponse;
  Map<String, double> personalityMap = {};
  late String personalityType;
  Color buttonColor = Colors.grey;
  bool buttonDisabled = true;

  @override
  void initState() {
    super.initState();
    _composition = _loadComposition();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    _controller.repeat();
    personalityType = "";
    makePostRequest();
  }

  makePostRequest() async {
    final uri = Uri.parse(
        'https://big-five-personality-insights.p.rapidapi.com/api/big5');
    final headers = {
      'content-type': 'application/json',
      'X-RapidAPI-Host': 'big-five-personality-insights.p.rapidapi.com',
      'X-RapidAPI-Key': '35ffad7e37mshc8f5fb94aeb7520p1ed63bjsn4f1b473b3784'
    };
    List<Map<String, String>> body = [
      {
        'id': "1",
        'language': 'en',
        'text': widget.userQuestionareResults.toString()
      }
    ];
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    statusCode = response.statusCode;
    finalResponse = response.body;
    personalityMap = parseResponseIntoMap(finalResponse);

    PersonalityClassifer classifier = PersonalityClassifer(personalityMap);

    setState(() {
      personalityType = classifier.classifyPersonality();
    });

    widget.currentUser.setPersonalityType = personalityType;
    FirebaseUpdater updater = FirebaseUpdater(widget.currentUser);
    await updater.updateUserDetails("Personality Type");
    FirebaseManager manager = FirebaseManager(widget.currentUser);
    await manager.categorizeUser().then((value) => {
          setState(() {
            buttonDisabled = false;
            buttonColor = AppStyle.red900;
          })
        });
  }

  Map<String, double> parseResponseIntoMap(String response) {
    List<String> splitResponse = response.split(",");
    Map<String, double> map = {};
    for (int i = 1; i < splitResponse.length; i++) {
      String key = splitResponse[i].split(":")[0];
      key = key.replaceAll('"', "");
      String value = splitResponse[i].split(":")[1];
      if (value.contains("}")) {
        value = value.replaceAll("}", "");
      }
      if (value.contains("]")) {
        value = value.replaceAll("]", "");
      }
      map[key] = double.parse(value);
    }
    return map;
  }

  late final AnimationController _controller;
  bool animationEnded = false;
  late final Future<LottieComposition> _composition;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<LottieComposition> _loadComposition() async {
    var assetData = await rootBundle.load('assets/animations/personality.json');
    return await LottieComposition.fromByteData(assetData);
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
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 25),
                  const SafeArea(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            "Personalities Matter!",
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
                  ),
                  const SizedBox(height: 25),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          "We think you are a person with a personality type of...",
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
                  const SizedBox(height: 50),
                  Align(
                    alignment: Alignment.center,
                    child: Wrap(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          personalityType,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: AppStyle.red600,
                            fontSize: 42,
                            fontFamily: 'Modern-Era',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 50),
                  Lottie(
                      width: 350,
                      height: 300,
                      repeat: true,
                      composition: composition,
                      controller: _controller,
                      fit: BoxFit.contain),
                  Expanded(
                    child: Container(),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if (!buttonDisabled) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    FutureHomeBufferBuilder(
                                      currentUser: widget.currentUser,
                                    )),
                            ModalRoute.withName('/'),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(35),
                        decoration: BoxDecoration(color: buttonColor),
                        child: const Center(
                            child: Text(
                          "Let's Get Matching!",
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
