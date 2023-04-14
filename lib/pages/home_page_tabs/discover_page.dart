import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/widgets/user_card.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  final List<CustomUser> matches;
  const DiscoverPage({super.key, required this.matches});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserCard(user: widget.matches[0]),
            ],
          ),
        ),
      ),
    );
  }
}
