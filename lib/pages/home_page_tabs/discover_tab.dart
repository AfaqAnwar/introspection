import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:datingapp/widgets/user_card.dart';
import 'package:flutter/material.dart';

class DiscoverTab extends StatefulWidget {
  final CustomUser currentUser;
  final List<CustomUser> matches;

  const DiscoverTab(
      {super.key, required this.matches, required this.currentUser});

  @override
  State<DiscoverTab> createState() => _DiscoverTabState();
}

class _DiscoverTabState extends State<DiscoverTab>
    with AutomaticKeepAliveClientMixin {
  late List<Widget> userCards;

  @override
  void initState() {
    super.initState();
    userCards = buildUserCards();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
            Expanded(
              child: Stack(
                children: userCards,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildUserCards() {
    List<Widget> userCards = [];
    for (var i = 0; i < widget.matches.length; i++) {
      userCards.add(Dismissible(
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              // TODO: Add to dislikes
              setState(() {
                userCards.removeAt(i);
              });
            } else if (direction == DismissDirection.startToEnd) {
              // TODO: Add to likes
              setState(() {
                userCards.removeAt(i);
              });
            }
          },
          direction: DismissDirection.horizontal,
          key: UniqueKey(),
          child: UserCard(user: widget.matches[i])));
    }
    return userCards;
  }
}
