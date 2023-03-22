import 'package:flutter/material.dart';
import 'package:flutter/src/material/icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/cupertino.dart';

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
    return Scaffold(
      backgroundColor: Colors.pink,
    );
  }
}
