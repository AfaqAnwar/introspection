import 'package:datingapp/pages/registration/registration_buffer.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/ethnicity_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/gender_preference_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/gender_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/height_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/location_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/initial_information/age_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/initial_information/email_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/initial_information/name_tab.dart';
import 'package:datingapp/pages/signin_signup/login_page.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:page_transition/page_transition.dart';
import '../../data/user.dart';

class RegisterPageHost extends StatefulWidget {
  const RegisterPageHost({super.key});

  @override
  State<RegisterPageHost> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPageHost> {
  late User user;
  int currentIndex = 0;
  int totalIndex = 20;
  final GlobalKey<NameTabState> _nameTabKey = GlobalKey();
  final GlobalKey<EmailTabState> _emailTabKey = GlobalKey();
  final GlobalKey<AgeTabState> _ageTabKey = GlobalKey();
  final GlobalKey<LocationTabState> _locationTabKey = GlobalKey();
  final GlobalKey<GenderTabState> _genderTabKey = GlobalKey();
  final GlobalKey<GenderPreferenceTabState> _genderPreferenceTabKey =
      GlobalKey();
  final GlobalKey<HeightTabState> _heightTabKey = GlobalKey();
  final GlobalKey<EthnicityTabState> _ethnicityTabKey = GlobalKey();
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    user = User();
  }

  void updateIndex() {
    if (currentIndex < totalIndex - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void updateIndexBackwards() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  Future<bool> checkFieldsAndUpdateCurrentUser() async {
    switch (currentIndex) {
      case 0:
        _nameTabKey.currentState!.updateNameOfUser();
        return _nameTabKey.currentState!.textFieldValidation();
      case 1:
        _emailTabKey.currentState!.updateUserEmail();
        return _emailTabKey.currentState!.emailTextValidation();
      case 2:
        _ageTabKey.currentState!.reset();
        bool changeScreen = false;
        if (_ageTabKey.currentState?.validateAge() == true) {
          _ageTabKey.currentState!.updateUserDob();
          changeScreen = await _ageTabKey.currentState!.showConfirmation();
        }
        return changeScreen;
      case 3:
        return true;
      case 4:
        _locationTabKey.currentState!.updateUserAddress();
        return _locationTabKey.currentState!.validateLocation();
      case 5:
        _genderTabKey.currentState!.updateUserGender();
        return _genderTabKey.currentState!.validateGender();
      case 6:
        _genderPreferenceTabKey.currentState!.updateUserGenderPreference();
        return _genderPreferenceTabKey.currentState!.validateGenderPreference();
      case 7:
        _heightTabKey.currentState!.updateUserHeight();
        return true;
      case 8:
        _ethnicityTabKey.currentState!.updateUserEthnicities();
        return _ethnicityTabKey.currentState!.validateEthnicities();
      default:
        return false;
    }
  }

  void destroyData() {
    switch (currentIndex) {
      case 0:
        user.setFirstName = "";
        user.setLastName = "";
        break;
      case 1:
        user.setEmail = "";
        break;
      case 2:
        user.setDob = "";
        break;
      case 3:
        break;
      case 4:
        user.setZipcode = "";
        user.setCity = "";
        user.setState = "";
        user.setCountry = "";
        break;
      case 5:
        user.setGender = "";
        break;
      case 6:
        user.setGenderPreference = "";
        break;
      case 7:
        user.setHeight = "";
        break;
      case 8:
        user.setEthnicities = [];
        break;
      default:
        break;
    }
  }

  void updateErrorMessage() {
    switch (currentIndex) {
      case 0:
        errorMessage = _nameTabKey.currentState!.getErrorMessage();
        break;
      case 1:
        errorMessage = _emailTabKey.currentState!.getErrorMessage();
        break;
      case 2:
        errorMessage = _ageTabKey.currentState!.getErrorMessage();
        break;
      case 4:
        errorMessage = _locationTabKey.currentState!.getErrorMessage();
        break;
      case 5:
        errorMessage = _genderTabKey.currentState!.getErrorMessage();
        break;
      case 6:
        errorMessage = _genderPreferenceTabKey.currentState!.getErrorMessage();
        break;
      case 7:
        errorMessage = "Unknown Error Occured";
        break;
      case 8:
        errorMessage = _ethnicityTabKey.currentState!.getErrorMessage();
        break;
      default:
        break;
    }
  }

  Widget showDotStepper() {
    if (currentIndex < 3) {
      return Column(
        children: [
          const SizedBox(height: 10),
          DotStepper(
            tappingEnabled: false,
            dotCount: 3,
            dotRadius: 6,
            activeStep: currentIndex,
            shape: Shape.circle,
            spacing: 10,
            indicator: Indicator.shift,
            fixedDotDecoration: FixedDotDecoration(
                color: Colors.grey.shade400,
                strokeColor: Colors.grey.shade400,
                strokeWidth: 1),
            indicatorDecoration: IndicatorDecoration(
                color: AppStyle.red500,
                strokeColor: AppStyle.red500,
                strokeWidth: 1),
          ),
          const SizedBox(height: 80),
        ],
      );
    }
    if (currentIndex == 4) {
      return Column(
        children: [
          const SizedBox(height: 10),
          DotStepper(
            tappingEnabled: false,
            dotCount: totalIndex - 4,
            dotRadius: 6,
            activeStep: currentIndex - 4,
            shape: Shape.circle,
            spacing: 10,
            indicator: Indicator.shift,
            fixedDotDecoration: FixedDotDecoration(
                color: Colors.grey.shade400,
                strokeColor: Colors.grey.shade400,
                strokeWidth: 1),
            indicatorDecoration: IndicatorDecoration(
                color: AppStyle.red500,
                strokeColor: AppStyle.red500,
                strokeWidth: 1),
          ),
          const SizedBox(height: 40),
        ],
      );
    }
    if (currentIndex > 4) {
      return Column(
        children: [
          const SizedBox(height: 10),
          DotStepper(
            tappingEnabled: false,
            dotCount: totalIndex - 4,
            dotRadius: 6,
            activeStep: currentIndex - 4,
            shape: Shape.circle,
            spacing: 10,
            indicator: Indicator.shift,
            fixedDotDecoration: FixedDotDecoration(
                color: Colors.grey.shade400,
                strokeColor: Colors.grey.shade400,
                strokeWidth: 1),
            indicatorDecoration: IndicatorDecoration(
                color: AppStyle.red500,
                strokeColor: AppStyle.red500,
                strokeWidth: 1),
          ),
          const SizedBox(height: 80),
        ],
      );
    } else {
      return const SizedBox(
        height: 40,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            splashRadius: 0.1,
            color: AppStyle.red800,
            onPressed: () async {
              destroyData();
              if (currentIndex == 0) {
                showDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                          title: const Text(
                            'Woah There!',
                            style: TextStyle(fontSize: 18),
                          ),
                          content: Column(
                            children: const [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Are you sure you want to exit?",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Cancel",
                                  style: TextStyle(color: AppStyle.red400)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: const LoginPage(),
                                        childCurrent: const RegisterPageHost(),
                                        type:
                                            PageTransitionType.leftToRightPop));
                              },
                              child: Text(
                                "Yes, take me back!",
                                style: TextStyle(color: AppStyle.red800),
                              ),
                            )
                          ],
                        ));
              }
              updateIndexBackwards();
            },
          ),
        ),
        bottomNavigationBar: buildBottomNavigationBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            child: SafeArea(
              child: Column(children: [
                showDotStepper(),
                updateBodyContent(),
              ]),
            ),
          ),
        ));
  }

  Widget buildBottomNavigationBar() {
    if (currentIndex != 3) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
        child: SafeArea(
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                      updateTab();
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return const SizedBox(
      height: 0,
    );
  }

  void showError() {
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
                    errorMessage.toString(),
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

  Future<void> updateTab() async {
    if (await checkFieldsAndUpdateCurrentUser()) {
      updateIndex();
      // Checks to see if we're in the age tab and did not confirm our age.
    } else if ((currentIndex == 2 &&
            _ageTabKey.currentState?.isConfirmed() == false &&
            !_ageTabKey.currentState!.isEditing()) ||
        currentIndex != 2) {
      updateErrorMessage();
      showError();
    }
  }

  Widget buildBufferPage() {
    final availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    return SizedBox(
      height: availableHeight,
      child: Column(
        children: [
          const RegisterBuffer(),
          Expanded(
            child: Container(),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                updateIndex();
              },
              child: Container(
                padding: const EdgeInsets.all(35),
                decoration: BoxDecoration(
                  color: AppStyle.red800,
                ),
                child: const Center(
                    child: Text(
                  "Enter Basic Information",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget updateBodyContent() {
    switch (currentIndex) {
      case 0:
        return NameTab(
          key: _nameTabKey,
          currentUser: user,
          updateIndex: updateIndex,
        );
      case 1:
        return EmailTab(
            key: _emailTabKey, currentUser: user, updateIndex: updateIndex);
      case 2:
        return AgeTab(
            key: _ageTabKey, currentUser: user, updateIndex: updateIndex);
      case 3:
        return buildBufferPage();
      case 4:
        return LocationTab(
            key: _locationTabKey, currentUser: user, updateIndex: updateIndex);
      case 5:
        return GenderTab(
            key: _genderTabKey, currentUser: user, updateIndex: updateIndex);
      case 6:
        return GenderPreferenceTab(
            key: _genderPreferenceTabKey,
            currentUser: user,
            updateIndex: updateIndex);
      case 7:
        return HeightTab(
            key: _heightTabKey, currentUser: user, updateIndex: updateIndex);
      case 8:
        return EthnicityTab(
            key: _ethnicityTabKey, currentUser: user, updateIndex: updateIndex);
      default:
        return const Text('Register Page');
    }
  }
}
