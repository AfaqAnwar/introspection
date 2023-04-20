import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/helpers/firebase_updater.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:datingapp/widgets/user_card.dart';
import 'package:flutter/material.dart';

class DiscoverTab extends StatefulWidget {
  final CustomUser currentUser;
  final List<CustomUser> potentialMatches;

  const DiscoverTab(
      {super.key, required this.potentialMatches, required this.currentUser});

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
  bool get wantKeepAlive => false;

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
    if (widget.potentialMatches.isEmpty) {
      return [
        Center(
          child: Text(
            "No people found",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Marlide-Display',
                color: AppStyle.red900),
          ),
        )
      ];
    }
    List<Widget> userCards = [];
    for (var i = 0; i < widget.potentialMatches.length; i++) {
      userCards.add(Dismissible(
          onDismissed: (direction) async {
            FirebaseUpdater updater = FirebaseUpdater(widget.currentUser);
            if (direction == DismissDirection.endToStart) {
              // Dislikes user
              widget.currentUser
                  .addDislikedUserID(widget.potentialMatches[i].getUid);
              updater.updateUserDetails("Disliked User IDS");
            } else if (direction == DismissDirection.startToEnd) {
              // Likes user
              if (checkIfLikeIsMutual(widget.potentialMatches[i])) {
                widget.currentUser
                    .addMatchedUserID(widget.potentialMatches[i].getUid);
                await updater.updateUserDetails("Matched User IDS");
              }
              widget.currentUser
                  .addLikedUserID(widget.potentialMatches[i].getUid);
              await updater.updateUserDetails("Liked User IDS");
            }
            setState(() {
              userCards.removeAt(i);
              widget.potentialMatches.removeAt(i);
            });
          },
          direction: DismissDirection.horizontal,
          key: UniqueKey(),
          child: UserCard(user: widget.potentialMatches[i])));
    }
    return userCards;
  }

  bool checkIfLikeIsMutual(CustomUser likedUser) {
    return likedUser.getLikedUserIDS.contains(widget.currentUser.getUid);
  }
}
