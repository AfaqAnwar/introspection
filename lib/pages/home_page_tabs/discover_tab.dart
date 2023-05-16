import 'package:introspection/data/custom_user.dart';
import 'package:introspection/helpers/firebase_updater.dart';
import 'package:introspection/helpers/firebase_user_builder.dart';
import 'package:introspection/pages/home_page_host.dart';
import 'package:introspection/style/app_style.dart';
import 'package:introspection/widgets/user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscoverTab extends StatefulWidget {
  final CustomUser currentUser;
  final List<CustomUser> potentialMatches;
  final GlobalKey<HomePageHostState> homePageHostKey;

  const DiscoverTab(
      {super.key,
      required this.potentialMatches,
      required this.currentUser,
      required this.homePageHostKey});

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
          background: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    CupertinoIcons.heart_fill,
                    color: AppStyle.red900,
                    size: 100,
                  ),
                ),
              ],
            ),
          ),
          secondaryBackground: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: Icon(
                    CupertinoIcons.heart_slash_fill,
                    color: AppStyle.red900,
                    size: 100,
                  ),
                ),
              ],
            ),
          ),
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
                widget.potentialMatches[i]
                    .addMatchedUserID(widget.currentUser.getUid);

                await updater.updateUserDetails("Matched User IDS");
                await updater.updateSpecifiedUsersDetails(
                    widget.potentialMatches[i], "Matched User IDS");

                widget.homePageHostKey.currentState!
                    .setMatches(await buildMatches());
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
}
