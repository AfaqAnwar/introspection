import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/helpers/discovery_manager.dart';
import 'package:datingapp/helpers/firebase_user_builder.dart';
import 'package:datingapp/pages/home_page_tabs/account_management/profile_tab.dart';
import 'package:datingapp/pages/home_page_tabs/discover_tab.dart';
import 'package:datingapp/pages/home_page_tabs/message_tab.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';

class HomePageHost extends StatefulWidget {
  final CustomUser currentUser;
  const HomePageHost({super.key, required this.currentUser});

  @override
  State<HomePageHost> createState() => _HomePageHostState();
}

class _HomePageHostState extends State<HomePageHost>
    with AutomaticKeepAliveClientMixin {
  late PageController _pageController;
  var currentIndex = 1;
  late List<CustomUser> potentialMatches;
  late List<CustomUser> matches;
  late Future<bool> isBuilt;

  @override
  void initState() {
    super.initState();
    isBuilt = Future.value(false);
    _pageController = PageController(initialPage: 1);
    potentialMatches = [];
    matches = [];
    getMatches();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
    getMatches();
  }

  @override
  bool get wantKeepAlive => true;

  void getMatches() async {
    DiscoveryManager discoveryManager = DiscoveryManager(widget.currentUser);
    await discoveryManager.discover();
    potentialMatches = discoveryManager.getPotentialMatches();
    await buildMatches().then((value) => () {
          matches = value;
        });
    isBuilt = Future.value(true);
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

  Widget buildContentOfTab(int index) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: <Widget>[
        MessageTab(currentUser: widget.currentUser, matches: matches),
        DiscoverTab(
            currentUser: widget.currentUser,
            potentialMatches: potentialMatches),
        ProfileTab(
          currentUser: widget.currentUser,
        ),
      ],
      onPageChanged: (index) => {
        setState(() {
          currentIndex = index;
        })
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
        future: isBuilt,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data == true) {
            return Scaffold(
              body: buildContentOfTab(currentIndex),
              bottomNavigationBar: BottomNavigationBar(
                elevation: 0,
                iconSize: 24,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                showUnselectedLabels: false,
                showSelectedLabels: false,
                currentIndex: currentIndex,
                onTap: _onItemTapped,
                items: [
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/icons/chat.png',
                        width: 24,
                        height: 24,
                        color: AppStyle.red800,
                      ),
                      label: "Messages"),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/heart.png',
                      width: 24,
                      height: 24,
                      color: AppStyle.red800,
                    ),
                    label: "Discover",
                  ),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/icons/account.png',
                        width: 24,
                        height: 24,
                        color: AppStyle.red800,
                      ),
                      label: "Profile"),
                ],
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppStyle.red900),
            ),
          );
        });
  }

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
      //
      //
      //using this page controller you can make beautiful animation effects
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    });
  }
}
