import 'package:datingapp/data/current_user.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';

class HomePageHost extends StatefulWidget {
  final CurrentUser currentUser;
  const HomePageHost({super.key, required this.currentUser});

  @override
  State<HomePageHost> createState() => _HomePageHostState();
}

class _HomePageHostState extends State<HomePageHost> {
  var currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget buildContentOfTab(int index) {
    switch (index) {
      case 0:
        return const Text("Home");
      case 1:
        return const Text("Home");
      case 2:
        return const Text("Home");
      default:
        return const Text("Home");
    }
  }

  Future checkIfUserIsLoggedIn() async {
    return widget.currentUser.isBuilt();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkIfUserIsLoggedIn(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data == true) {
            return Scaffold(
              body: buildContentOfTab(currentIndex),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.shifting,
                backgroundColor: Colors.white,
                showUnselectedLabels: false,
                currentIndex: currentIndex,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                selectedItemColor: AppStyle.red600,
                unselectedItemColor: AppStyle.red300,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.star),
                    label: "Discover",
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.message), label: "Messages"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "Profile"),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
