import 'package:datingapp/data/custom_user.dart';
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

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  Widget buildContentOfTab(int index) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: <Widget>[
        const MessageTab(),
        DiscoverTab(
            matches: [widget.currentUser], currentUser: widget.currentUser),
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

  Future checkIfUserIsLoggedIn() async {
    return widget.currentUser.isBuilt();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
        future: checkIfUserIsLoggedIn(),
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
          } else {
            return const Center(child: CircularProgressIndicator());
          }
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
