import 'package:datingapp/components/profile_tab_components/profile_user_field_tile.dart';
import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/helpers/firebase_updater.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/alcohol_preference_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/drug_preference_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/education_level_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/ethnicity_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/gender_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/height_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/hometown_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/job_title_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/political_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/religion_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/school_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/smoke_preference_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/weed_preference_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/work_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/information_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/initial_information/name_tab.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                List<String> fields = [];
                fields.add("First Name");
                fields.add("Last Name");
                GlobalKey<NameTabState> key = GlobalKey<NameTabState>();
                pushToPage(
                    NameTab(
                        key: key,
                        currentUser: widget.currentUser,
                        updateIndex: () {}),
                    key,
                    fields);
                break;
              case "Gender":
                List<String> fields = [];
                fields.add("Gender");
                GlobalKey<GenderTabState> key = GlobalKey<GenderTabState>();
                pushToPage(
                    GenderTab(
                        key: key,
                        currentUser: widget.currentUser,
                        updateIndex: () {}),
                    key,
                    fields);
                break;
              case "Height":
                List<String> fields = [];
                fields.add("Height");
                GlobalKey<HeightTabState> key = GlobalKey<HeightTabState>();
                pushToPage(
                    HeightTab(
                        key: key,
                        currentUser: widget.currentUser,
                        updateIndex: () {}),
                    key,
                    fields);
                break;
              case "Ethnicities":
                //TODO: FIX WEIRD BUG WHERE CURRENT USER IS UPDATED!!???
                List<String> fields = [];
                fields.add("Ethnicities");
                GlobalKey<EthnicityTabState> key =
                    GlobalKey<EthnicityTabState>();
                pushToPage(
                    EthnicityTab(
                        key: key,
                        currentUser: widget.currentUser,
                        updateIndex: () {}),
                    key,
                    fields);
                break;
              case "Hometown":
                List<String> fields = [];
                fields.add("Hometown");
                GlobalKey<HometownTabState> key = GlobalKey<HometownTabState>();
                pushToPage(
                    HometownTab(
                        key: key,
                        currentUser: widget.currentUser,
                        updateIndex: () {}),
                    key,
                    fields);
                break;
              case "Work":
                List<String> fields = [];
                fields.add("Work");
                GlobalKey<WorkTabState> key = GlobalKey<WorkTabState>();
                pushToPage(
                    WorkTab(
                        key: key,
                        currentUser: widget.currentUser,
                        updateIndex: () {}),
                    key,
                    fields);
                break;
              case "Job Title":
                List<String> fields = [];
                fields.add("Job Title");
                GlobalKey<JobTitleTabState> key = GlobalKey<JobTitleTabState>();
                pushToPage(
                    JobTitleTab(
                        key: key,
                        currentUser: widget.currentUser,
                        updateIndex: () {}),
                    key,
                    fields);
                break;
              case "School":
                List<String> fields = [];
                fields.add("School");
                GlobalKey<SchoolTabState> key = GlobalKey<SchoolTabState>();
                pushToPage(
                    SchoolTab(
                        key: key,
                        currentUser: widget.currentUser,
                        updateIndex: () {}),
                    key,
                    fields);
                break;
              case "Education Level":
                List<String> fields = [];
                fields.add("Education Level");
                GlobalKey<EducationLevelTabState> key =
                    GlobalKey<EducationLevelTabState>();
                pushToPage(
                    EducationLevelTab(
                        key: key,
                        currentUser: widget.currentUser,
                        updateIndex: () {}),
                    key,
                    fields);
                break;
              case "Religion":
                List<String> fields = [];
                fields.add("Religion");
                GlobalKey<ReligionTabState> key = GlobalKey<ReligionTabState>();
                pushToPage(
                    ReligionTab(
                        key: key,
                        currentUser: widget.currentUser,
                        updateIndex: () {}),
                    key,
                    fields);
                break;
              case "Political Belief":
                List<String> fields = [];
                fields.add("Political Belief");
                GlobalKey<PoliticalBeliefTabState> key =
                    GlobalKey<PoliticalBeliefTabState>();
                pushToPage(
                    PoliticalBeliefTab(
                        key: key,
                        currentUser: widget.currentUser,
                        updateIndex: () {}),
                    key,
                    fields);
                break;
              case "Alcohol Preference":
                List<String> fields = [];
                fields.add("Alcohol Preference");
                GlobalKey<AlcoholPreferenceTabState> key =
                    GlobalKey<AlcoholPreferenceTabState>();
                pushToPage(
                    AlcoholPreferenceTab(
                        key: key,
                        currentUser: widget.currentUser,
                        updateIndex: () {}),
                    key,
                    fields);
                break;
              case "Smoking Preference":
                List<String> fields = [];
                fields.add("Smoking Preference");
                GlobalKey<SmokePreferenceTabState> key =
                    GlobalKey<SmokePreferenceTabState>();
                pushToPage(
                    SmokePreferenceTab(
                        key: key,
                        currentUser: widget.currentUser,
                        updateIndex: () {}),
                    key,
                    fields);
                break;
              case "Weed Preference":
                List<String> fields = [];
                fields.add("Weed Preference");
                GlobalKey<WeedPreferenceTabState> key =
                    GlobalKey<WeedPreferenceTabState>();
                pushToPage(
                    WeedPreferenceTab(
                        key: key,
                        currentUser: widget.currentUser,
                        updateIndex: () {}),
                    key,
                    fields);
                break;
              case "Drugs Preference":
                List<String> fields = [];
                fields.add("Drug Preference");
                GlobalKey<DrugPreferenceTabState> key =
                    GlobalKey<DrugPreferenceTabState>();
                pushToPage(
                    DrugPreferenceTab(
                        key: key,
                        currentUser: widget.currentUser,
                        updateIndex: () {}),
                    key,
                    fields);
                break;
            }
          }));
    }

    return tiles;
  }

  bool checkIfUserIsLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
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

  void pushToPage(Widget page, GlobalKey key, List<String> fields) {
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
                                        if (InformationTab.staticHasChanged()) {
                                          FirebaseUpdater updater =
                                              FirebaseUpdater(
                                                  widget.currentUser);
                                          for (var field in fields) {
                                            InformationTab
                                                .staticUpdateUserInformation();
                                            await updater
                                                .updateUserDetails(field);
                                          }
                                        }
                                        Future.delayed(
                                            const Duration(milliseconds: 500),
                                            () {
                                          Navigator.pop(context);
                                        });
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
