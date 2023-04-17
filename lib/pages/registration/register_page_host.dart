import 'package:datingapp/pages/registration/basic_information_buffer.dart';
import 'package:datingapp/pages/registration/finalization_buffer.dart';
import 'package:datingapp/pages/registration/registration_buffer.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/alcohol_preference_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/children_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/drug_preference_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/education_level_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/ethnicity_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/gender_preference_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/gender_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/height_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/hometown_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/job_title_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/location_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/political_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/religion_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/school_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/smoke_preference_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/weed_preference_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/basic_information/work_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/initial_information/age_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/initial_information/email_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/initial_information/name_tab.dart';
import 'package:datingapp/pages/registration/registration_tabs/user_photographic_information/photo_tab.dart';
import 'package:datingapp/pages/signin_signup/login_page.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:page_transition/page_transition.dart';
import '../../data/current_user.dart';

class RegisterPageHost extends StatefulWidget {
  const RegisterPageHost({super.key});

  @override
  State<RegisterPageHost> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPageHost> {
  late CurrentUser user;

  int currentIndex = 0;
  int currentKeyIndex = 0;
  int totalIndex = 24;

  late GlobalKey _currentKey;
  List<GlobalKey> keys = [];

  // Global Keys for each tab
  final GlobalKey<NameTabState> _nameTabKey = GlobalKey();
  final GlobalKey<EmailTabState> _emailTabKey = GlobalKey();
  final GlobalKey<AgeTabState> _ageTabKey = GlobalKey();
  final GlobalKey<LocationTabState> _locationTabKey = GlobalKey();
  final GlobalKey<GenderTabState> _genderTabKey = GlobalKey();
  final GlobalKey<GenderPreferenceTabState> _genderPreferenceTabKey =
      GlobalKey();
  final GlobalKey<HeightTabState> _heightTabKey = GlobalKey();
  final GlobalKey<EthnicityTabState> _ethnicityTabKey = GlobalKey();
  final GlobalKey<ChildrenTabState> _childrenTabKey = GlobalKey();
  final GlobalKey<HometownTabState> _hometownTabKey = GlobalKey();
  final GlobalKey<WorkTabState> _workTabKey = GlobalKey();
  final GlobalKey<JobTitleTabState> _jobTitleTabKey = GlobalKey();
  final GlobalKey<SchoolTabState> _schoolTabKey = GlobalKey();
  final GlobalKey<EducationLevelTabState> _educationLevelTabKey = GlobalKey();
  final GlobalKey<ReligionTabState> _religionTabKey = GlobalKey();
  final GlobalKey<PoliticalBeliefTabState> _politicalBeliefTabKey = GlobalKey();
  final GlobalKey<AlcoholPreferenceTabState> _alcoholPreferenceTabKey =
      GlobalKey();
  final GlobalKey<SmokePreferenceTabState> _smokePreferenceTabKey = GlobalKey();
  final GlobalKey<WeedPreferenceTabState> _weedPreferenceTabKey = GlobalKey();
  final GlobalKey<DrugPreferenceTabState> _drugPreferenceTabKey = GlobalKey();
  final GlobalKey<PhotoTabState> _photoTabKey = GlobalKey();

  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    user = CurrentUser();
    keys = [
      _nameTabKey,
      _emailTabKey,
      _ageTabKey,
      _locationTabKey,
      _genderTabKey,
      _genderPreferenceTabKey,
      _heightTabKey,
      _ethnicityTabKey,
      _childrenTabKey,
      _hometownTabKey,
      _workTabKey,
      _jobTitleTabKey,
      _schoolTabKey,
      _educationLevelTabKey,
      _religionTabKey,
      _politicalBeliefTabKey,
      _alcoholPreferenceTabKey,
      _smokePreferenceTabKey,
      _weedPreferenceTabKey,
      _drugPreferenceTabKey,
      _photoTabKey,
    ];
    _currentKey = keys[currentKeyIndex];
  }

  void updateIndex() {
    if (currentIndex < totalIndex - 1) {
      setState(() {
        // Check to see if we're crossing a UI seperator screen next (index of (3) comes after (2)).
        if (currentIndex != 2 && currentIndex != 21 && currentIndex != 22) {
          currentKeyIndex++;
        }

        currentIndex++;
        updateKey(currentKeyIndex);
      });
    }
  }

  void updateIndexBackwards() {
    if (currentIndex > 0) {
      setState(() {
        // Check to see if we're crossing a UI seperator screen (index of 3).
        if (currentIndex != 3 && currentIndex != 22) {
          currentKeyIndex--;
        }
        currentIndex--;
        updateKey(currentKeyIndex);
      });
    }
  }

  void updateKey(int index) {
    _currentKey = keys[index];
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
      case 9:
        _childrenTabKey.currentState!.updateChildrenQuestions();
        return _childrenTabKey.currentState!.validateChildrenQuestions();
      case 10:
        _hometownTabKey.currentState!.updateHometownOfUser();
        return _hometownTabKey.currentState!.textFieldValidation();
      case 11:
        _workTabKey.currentState!.updateWorkOfUser();
        return true;
      case 12:
        _jobTitleTabKey.currentState!.updateJobTitleOfUser();
        return _jobTitleTabKey.currentState!.textFieldValidation();
      case 13:
        _schoolTabKey.currentState!.updateSchoolOfUser();
        return _schoolTabKey.currentState!.textFieldValidation();
      case 14:
        _educationLevelTabKey.currentState!.updateEducationLevelOfUser();
        return _educationLevelTabKey.currentState!.validateEducationLevel();
      case 15:
        _religionTabKey.currentState!.updateReligionOfUser();
        return _religionTabKey.currentState!.validateReligion();
      case 16:
        _politicalBeliefTabKey.currentState!.updatePoliticalBeliefOfUser();
        return _politicalBeliefTabKey.currentState!.validatePoliticalBelief();
      case 17:
        _alcoholPreferenceTabKey.currentState!.updateAlcoholPreferenceOfUser();
        return _alcoholPreferenceTabKey.currentState!
            .validateAlcoholPreference();
      case 18:
        _smokePreferenceTabKey.currentState!.updateSmokePreferenceOfUser();
        return _smokePreferenceTabKey.currentState!.validateSmokePreference();
      case 19:
        _weedPreferenceTabKey.currentState!.updateWeedPreferenceOfUser();
        return _weedPreferenceTabKey.currentState!.validateWeedPreference();
      case 20:
        _drugPreferenceTabKey.currentState!.updateDrugPreferenceOfUser();
        return _drugPreferenceTabKey.currentState!.validateDrugPreference();
      case 21:
        return true;
      case 22:
        return _photoTabKey.currentState!.validatePhotos();
      case 23:
        return true;
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
      case 9:
        user.hasChildren = null;
        user.setChildrenPreference = "";
        break;
      case 10:
        user.setHometown = "";
        break;
      case 11:
        user.setWork = "";
        break;
      case 12:
        user.setJobTitle = "";
        break;
      case 13:
        user.setSchool = "";
        break;
      case 14:
        user.setEducationLevel = "";
        break;
      case 15:
        user.setReligion = "";
        break;
      case 16:
        user.setPoliticalBelief = "";
        break;
      case 17:
        user.setAlcoholPreference = "";
        break;
      case 18:
        user.setSmokePreference = "";
        break;
      case 19:
        user.setWeedPreference = "";
        break;
      case 20:
        user.setDrugPreference = "";
        break;
      case 21:
        break;
      case 22:
        user.clearImages();
        break;
      case 23:
        break;
      default:
        break;
    }
  }

  void updateErrorMessage() {
    errorMessage = _currentKey.currentState!.toStringShort();
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
            spacing: 8,
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
    if (currentIndex > 4 && currentIndex < 21) {
      return Column(
        children: [
          const SizedBox(height: 10),
          DotStepper(
            tappingEnabled: false,
            dotCount: totalIndex - 7,
            dotRadius: 6,
            activeStep: currentIndex - 4,
            shape: Shape.circle,
            spacing: 8,
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
        height: 25,
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
            checkAndReturnToLogin();
            updateIndexBackwards();
          },
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
      backgroundColor: Colors.white,
      body: buildBody(),
    );
  }

  Widget buildBody() {
    if (currentIndex == 3 || currentIndex == 21 || currentIndex == 23) {
      return updateBodyContent();
    } else {
      return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          child: SafeArea(
            child: Column(children: [
              showDotStepper(),
              updateBodyContent(),
            ]),
          ),
        ),
      );
    }
  }

  Widget buildBottomNavigationBar() {
    if (currentIndex != 3 && currentIndex != 21 && currentIndex != 23) {
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

  void checkAndReturnToLogin() {
    if (currentIndex == 0) {
      showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                title: const Text(
                  'Woah There!',
                  style: TextStyle(fontSize: 18),
                ),
                content: Column(
<<<<<<< Updated upstream
                  children: const [
=======
                  children: [
>>>>>>> Stashed changes
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
                              type: PageTransitionType.leftToRightPop));
                    },
                    child: Text(
                      "Yes, take me back!",
                      style: TextStyle(color: AppStyle.red800),
                    ),
                  )
                ],
              ));
    }
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
        return RegisterBuffer(onContinue: updateIndex);
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

      case 9:
        return ChildrenTab(
            key: _childrenTabKey, currentUser: user, updateIndex: updateIndex);
      case 10:
        return HometownTab(
            key: _hometownTabKey, currentUser: user, updateIndex: updateIndex);
      case 11:
        return WorkTab(
            key: _workTabKey, currentUser: user, updateIndex: updateIndex);
      case 12:
        return JobTitleTab(
            key: _jobTitleTabKey, currentUser: user, updateIndex: updateIndex);
      case 13:
        return SchoolTab(
            key: _schoolTabKey, currentUser: user, updateIndex: updateIndex);
      case 14:
        return EducationLevelTab(
            key: _educationLevelTabKey,
            currentUser: user,
            updateIndex: updateIndex);
      case 15:
        return ReligionTab(
            key: _religionTabKey, currentUser: user, updateIndex: updateIndex);
      case 16:
        return PoliticalBeliefTab(
            key: _politicalBeliefTabKey,
            currentUser: user,
            updateIndex: updateIndex);
      case 17:
        return AlcoholPreferenceTab(
            key: _alcoholPreferenceTabKey,
            currentUser: user,
            updateIndex: updateIndex);
      case 18:
        return SmokePreferenceTab(
            key: _smokePreferenceTabKey,
            currentUser: user,
            updateIndex: updateIndex);
      case 19:
        return WeedPreferenceTab(
            key: _weedPreferenceTabKey,
            currentUser: user,
            updateIndex: updateIndex);
      case 20:
        return DrugPreferenceTab(
            key: _drugPreferenceTabKey,
            currentUser: user,
            updateIndex: updateIndex);
      case 21:
        return BasicInformationBuffer(onContinue: updateIndex);
      case 22:
        return PhotoTab(
            key: _photoTabKey, currentUser: user, updateIndex: updateIndex);
      case 23:
        return FinalizationBuffer(currentUser: user);
      default:
        return const CircularProgressIndicator();
    }
  }
}
