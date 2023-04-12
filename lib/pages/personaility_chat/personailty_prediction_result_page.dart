import 'package:datingapp/data/current_user.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';

class PersonailtyPredictionResultPage extends StatefulWidget {
  final CurrentUser currentUser;
  const PersonailtyPredictionResultPage(
      {super.key,
      required this.userQuestionareResults,
      required this.currentUser});

  @override
  State<PersonailtyPredictionResultPage> createState() =>
      _PersonailtyPredictionResultPage();

  //State<PersonailtyPredictionResultPage> createState1() =>
  //  PersonalityPredictor();

  final String userQuestionareResults;
}

class _PersonailtyPredictionResultPage
    extends State<PersonailtyPredictionResultPage>
    with TickerProviderStateMixin {
  late int statusCode;
  late String finalResponse;
  Map<String, double> personalityMap = {};

  @override
  void initState() {
    super.initState();
    _composition = _loadComposition();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    _controller.repeat();

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
    print(personalityMap);
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


  void PersonalityConverter (Map<String, double> map) 
  {
    String bigfiveattribute = "";
    double key = 1;
    int letter_counter = 0;

    for(double i = key; i < personalityMap.length; i++){
      if(i == 1 || i == 4 || i == 5 || i == 21 || i == 22 || i == 26 || i == 27 || i == 28 || i == 35) 
      {
          if(0 <= i || i < 0.5) {
            add bigfiveattribute = "I" to map;
          } 
          else if(0.5 < i || i <= 1) {
            add bigfiveattribute = "E" to map;
          }  
      }
      else if(i == 2 || i == 7 || i == 8 || i == 9 || i == 11 || i == 17 || i == 19 || i == 23 || i == 32){

         if(0 <= i || i < 0.5) {
           add bigfiveattribute = "S" to map;
         } 
         else if(0.5 < i || i <= 1) {
           add bigfiveattribute = "N" to map;
         }  
        
      }
      else if(i == 3 || i == 10 || i == 14 || i == 15 || i == 24 || i == 25 || i == 29 || i == 33 || i == 34){
        
         if(0 <= i || i < 0.5) {
           add bigfiveattribute = "T" to map;
         } 
         else if(0.5 < i || i <= 1) {
           add bigfiveattribute = "F" to map;
         }  
      }
      else if(i == 6|| i == 12 || i == 13 || i == 16 || i == 18 || i == 20 || i == 30 || i == 31){
         
         if(0 <= i || i < 0.5) {
           add bigfiveattribute = "J" to map;
         } 
         else if(0.5 < i || i <= 1) {
           add bigfiveattribute = "P" to map;
         }  
      }
    }

    
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
                  const SizedBox(height: 50),
                  SafeArea(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(children: const [
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
                  SafeArea(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            "We think you are a person with a personality type of.",
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
                  ),
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
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(35),
                        decoration: BoxDecoration(color: AppStyle.red800),
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
