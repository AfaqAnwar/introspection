import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/data/current_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseLoginHelper {
  late CurrentUser currentUser;

  FirebaseLoginHelper() {
    currentUser = CurrentUser();
  }

  Future<void> populateUserData() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser!.uid)
        .get();
    currentUser.setFirstName = data.get('First Name');
    currentUser.setLastName = data.get('Last Name');
    currentUser.setEmail = data.get('Email');
    currentUser.setDob = data.get('DOB');
    currentUser.setZipcode = data.get('Zip Code');
    currentUser.setCity = data.get('City');
    currentUser.setState = data.get('State');
    currentUser.setCountry = data.get('Country');
    currentUser.setGender = data.get('Gender');
    currentUser.setGenderPreference = data.get('Gender Preference');
    currentUser.setHeight = data.get('Height');
    currentUser.setEthnicities = decodeDynamicList(data.get('Ethnicities'));
    currentUser.setHasChildren = data.get('Has Children');
    currentUser.setChildrenPreference = data.get('Wants Children');
    currentUser.setHometown = data.get('Hometown');
    currentUser.setWork = data.get('Work');
    currentUser.setJobTitle = data.get('Job Title');
    currentUser.setSchool = data.get('School');
    currentUser.setEducationLevel = data.get('Education Level');
    currentUser.setReligion = data.get('Religion');
    currentUser.setPoliticalBelief = data.get('Political Belief');
    currentUser.setAlcoholPreference = data.get('Alcohol Preference');
    currentUser.setSmokePreference = data.get('Smoking Preference');
    currentUser.setDrugPreference = data.get('Drugs Preference');
    currentUser.setPersonalityType = data.get('Personality Type');
    print(currentUser.getPersonalityType);
  }

  CurrentUser getCurrentUser() {
    return currentUser;
  }

  List<String> decodeDynamicList(List<dynamic> data) {
    List<String> ethnicities = [];
    for (int i = 0; i < data.length; i++) {
      ethnicities.add(data[i].toString());
    }
    return ethnicities;
  }
}
