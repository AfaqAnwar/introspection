import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/data/current_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRegistrationHelper {
  late CurrentUser currentUser;

  FirebaseRegistrationHelper(CurrentUser givenUser) {
    currentUser = givenUser;
  }

  Future<String> registerUser(String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: currentUser.getEmail, password: password);
      return "Success";
    } catch (error) {
      return error.toString();
    }
  }

  Future addUserDetails() async {
    DocumentReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    List<dynamic> ethnicities = currentUser.getEthnicities;
    ref.set({
      'First Name': currentUser.getFirstName,
      'Last Name': currentUser.getLastName,
      'Email': currentUser.getEmail,
      'DOB': currentUser.getDob,
      'Zip Code': currentUser.getZipcode,
      'City': currentUser.getCity,
      'State': currentUser.getState,
      'Country': currentUser.getCountry,
      'Gender': currentUser.getGender,
      'Gender Preference': currentUser.getGenderPreference,
      'Height': currentUser.getHeight,
      'Ethnicities': ethnicities,
      'Has Children': currentUser.getHasChildren,
      'Wants Children': currentUser.getChildrenPreference,
      'Hometown': currentUser.getHometown,
      'Work': currentUser.getWork,
      'Job Title': currentUser.getJobTitle,
      'School': currentUser.getSchool,
      'Education Level': currentUser.getEducationLevel,
      'Religion': currentUser.getReligion,
      'Political Belief': currentUser.getPoliticalBelief,
      'Alcohol Preference': currentUser.getAlcoholPreference,
      'Smoking Preference': currentUser.getSmokePreference,
      'Drugs Preference': currentUser.getDrugPreference,
    });
  }
}
