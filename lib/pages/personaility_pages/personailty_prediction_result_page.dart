import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.lightGreen,
    );
  }
}
