import 'package:datingapp/components/profile_tab_components/profile_user_field_tile.dart';
import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/pages/registration/registration_tabs/information_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/initial_information/name_tab.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  final CustomUser currentUser;
  const AccountPage({super.key, required this.currentUser});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late List<Widget> tiles;
  late String error;

  @override
  void initState() {
    super.initState();
    tiles = [];
    error = "";
  }

  Future setTiles() async {
    tiles = buildTiles(widget.currentUser.getAccountFields);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: setTiles(),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    splashRadius: 0.1,
                    color: AppStyle.red800,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                title: Text("Personal Information",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Marlide-Display',
                        color: AppStyle.red700)),
              ),
              body: ListView.builder(
                  itemCount: tiles.length,
                  itemBuilder: (context, index) {
                    return tiles[index];
                  }),
            );
          } else {
            return const Scaffold(
                backgroundColor: Colors.white,
                body: CircularProgressIndicator());
          }
        });
  }

  List<Widget> buildTiles(List<String> fields) {
    List<Widget> tiles = [];

    for (var field in fields) {
      tiles.add(ProfileUserFieldTile(
          text: field,
          onTap: () {
            switch (field) {
              case "Name":
                GlobalKey<NameTabState> key = GlobalKey<NameTabState>();
                pushToPage(
                    NameTab(
                        key: key,
                        currentUser: widget.currentUser,
                        updateIndex: () {}),
                    key);
                break;
            }
          }));
    }

    return tiles;
  }

  void showErrorMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: const Text(
                'Whoops!',
                style: TextStyle(fontSize: 18),
              ),
              content: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    error,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Okay",
                    style: TextStyle(color: AppStyle.red800),
                  ),
                )
              ],
            ));
  }

  void pushToPage(Widget page, GlobalKey key) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    splashRadius: 0.1,
                    color: AppStyle.red800,
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                ),
                bottomNavigationBar: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 30),
                    child: SafeArea(
                        child: Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  RawMaterialButton(
                                    elevation: 0,
                                    constraints: const BoxConstraints(
                                      minWidth: 50,
                                      minHeight: 50,
                                    ),
                                    fillColor: AppStyle.red900,
                                    shape: const CircleBorder(),
                                    onPressed: () async {
                                      InformationTab.initializeWith(
                                          key.currentState as InformationTab);
                                      if (InformationTab.staticValidate()) {
                                        InformationTab
                                            .staticUpdateUserInformation();

                                        Navigator.pop(context);
                                      } else {
                                        error = InformationTab
                                            .staticGetErrorMessage();
                                        showErrorMessage(context);
                                      }
                                    },
                                    child: const Icon(
                                      CupertinoIcons.check_mark,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )))),
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: SizedBox(child: SafeArea(child: page))),
              )),
    );
  }
}
