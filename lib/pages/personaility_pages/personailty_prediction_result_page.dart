import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sklite/naivebayes/naive_bayes.dart';
import 'package:sklite/utils/io.dart';

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
  late GaussianNB nb;
  @override
  void initState() {
    super.initState();
    loadModel("assets/data/models/nm_ei.json").then((x) {
      nb = GaussianNB.fromMap(jsonDecode(x));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.lightGreen,
    );
  }
}
