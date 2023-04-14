import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/style/app_style.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("Discover",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Marlide-Display',
                  color: AppStyle.red700))),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserCard(user: widget.matches[0]),
            const Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
