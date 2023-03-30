import 'package:flutter/material.dart';
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';

class PersonailtyPredictionResultPage extends StatefulWidget {
  const PersonailtyPredictionResultPage(
      {super.key, required this.userQuestionareResults});

  @override
  State<PersonailtyPredictionResultPage> createState() =>
      _PersonailtyPredictionResultPage();
  final String userQuestionareResults;
}

class _PersonailtyPredictionResultPage
    extends State<PersonailtyPredictionResultPage> {
  @override
  void initState() {
    super.initState();
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

    int statusCode = response.statusCode;
    String responseBody = response.body;

    print(statusCode);
    print(responseBody);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.lightGreen,
    );
  }
}
