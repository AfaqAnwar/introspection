import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/helpers/discovery_manager.dart';
import 'package:datingapp/helpers/firebase_user_builder.dart';
import 'package:datingapp/pages/home_page_host.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';

class FutureHomeBufferBuilder extends StatefulWidget {
  final CustomUser currentUser;
  const FutureHomeBufferBuilder({super.key, required this.currentUser});

  @override
  State<FutureHomeBufferBuilder> createState() =>
      _FutureHomeBufferBuilderState();
}

class _FutureHomeBufferBuilderState extends State<FutureHomeBufferBuilder> {
  late List<CustomUser> potentialMatches;
  late List<CustomUser> matches;

  @override
  void initState() {
    potentialMatches = [];
    matches = [];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getMatches() async {
    DiscoveryManager discoveryManager = DiscoveryManager(widget.currentUser);
    await discoveryManager.discover();
    potentialMatches = discoveryManager.getPotentialMatches();
    await buildMatches().then((value) => matches = value);
    return true;
  }

  Future<List<CustomUser>> buildMatches() async {
    List<CustomUser> matches = [];
    if (widget.currentUser.getMatchedUserIDS.isEmpty) return matches;
    for (var match in widget.currentUser.getMatchedUserIDS) {
      FirebaseUserBuilder builder = FirebaseUserBuilder(match);
      CustomUser user = CustomUser();
      await builder.buildUser().then((value) => user = value);
      matches.add(user);
    }

    return matches;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMatches(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Future.delayed(Duration.zero, () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePageHost(
                        currentUser: widget.currentUser,
                        potentialMatches: potentialMatches,
                        matches: matches)));
          });
        }
        return Center(child: CircularProgressIndicator(color: AppStyle.red900));
      },
    );
  }
}
