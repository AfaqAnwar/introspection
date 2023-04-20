import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/data/custom_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUpdater {
  late CustomUser currentUser;

  FirebaseUpdater(CustomUser givenUser) {
    currentUser = givenUser;
  }

  Future updateUserDetails(String field) async {
    DocumentReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    switch (field) {
      case "First Name":
        ref.update({'First Name': currentUser.getFirstName});
        break;
      case "Last Name":
        ref.update({'Last Name': currentUser.getLastName});
        break;
      case "Email":
        ref.update({'Email': currentUser.getEmail});
        break;
      case "DOB":
        ref.update({'DOB': currentUser.getDob});
        break;
      case "Zip Code":
        ref.update({'Zip Code': currentUser.getZipcode});
        break;
      case "City":
        ref.update({'City': currentUser.getCity});
        break;
      case "State":
        ref.update({'State': currentUser.getState});
        break;
      case "Country":
        ref.update({'Country': currentUser.getCountry});
        break;
      case "Gender":
        ref.update({'Gender': currentUser.getGender});
        break;
      case "Gender Preference":
        ref.update({'Gender  Preference': currentUser.getGenderPreference});
        break;
      case "Height":
        ref.update({'Height': currentUser.getHeight});
        break;
      case "Ethnicities":
        List<dynamic> ethnicities = currentUser.getEthnicities;
        ref.update({'Ethnicities': ethnicities});
        break;
      case "Has Children":
        ref.update({'Has Children': currentUser.getHasChildren});
        break;
      case "Wants Children":
        ref.update({'Wants Children': currentUser.getChildrenPreference});
        break;
      case "Hometown":
        ref.update({'Hometown': currentUser.getHometown});
        break;
      case "Work":
        ref.update({'Work': currentUser.getWork});
        break;
      case "Job Title":
        ref.update({'Job Title': currentUser.getJobTitle});
        break;
      case "School":
        ref.update({'School': currentUser.getSchool});
        break;
      case "Education Level":
        ref.update({'Education Level': currentUser.getEducationLevel});
        break;
      case "Religion":
        ref.update({'Religion': currentUser.getReligion});
        break;
      case "Political Belief":
        ref.update({'Political Belief': currentUser.getPoliticalBelief});
        break;
      case "Alcohol Preference":
        ref.update({'Alcohol Preference': currentUser.getAlcoholPreference});
        break;
      case "Smoking Preference":
        ref.update({'Smoking Preference': currentUser.getSmokePreference});
        break;
      case "Drugs Preference":
        ref.update({'Drugs Preference': currentUser.getDrugPreference});
        break;
      case "Weed Preference":
        ref.update({'Weed Preference': currentUser.getWeedPreference});
        break;
      case "Personality Type":
        ref.update({'Personality Type': currentUser.getPersonalityType});
        break;
      case "Liked User IDS":
        ref.update({'Liked User IDS': currentUser.getLikedUserIDS});
        break;
      case "Disliked User IDS":
        ref.update({'Disliked User IDS': currentUser.getDislikedUserIDS});
        break;
      case "Matched User IDS":
        ref.update({'Matched User IDS': currentUser.getMatchedUserIDS});
        break;
    }

    return "Success";
  }

  Future updateSpecifiedUsersDetails(CustomUser user, String field) async {
    DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(user.getUid);
    switch (field) {
      case "First Name":
        ref.update({'First Name': user.getFirstName});
        break;
      case "Last Name":
        ref.update({'Last Name': user.getLastName});
        break;
      case "Email":
        ref.update({'Email': user.getEmail});
        break;
      case "DOB":
        ref.update({'DOB': user.getDob});
        break;
      case "Zip Code":
        ref.update({'Zip Code': user.getZipcode});
        break;
      case "City":
        ref.update({'City': user.getCity});
        break;
      case "State":
        ref.update({'State': user.getState});
        break;
      case "Country":
        ref.update({'Country': user.getCountry});
        break;
      case "Gender":
        ref.update({'Gender': user.getGender});
        break;
      case "Gender Preference":
        ref.update({'Gender Preference': user.getGenderPreference});
        break;
      case "Height":
        ref.update({'Height': user.getHeight});
        break;
      case "Ethnicities":
        List<dynamic> ethnicities = user.getEthnicities;
        ref.update({'Ethnicities': ethnicities});
        break;
      case "Has Children":
        ref.update({'Has Children': user.getHasChildren});
        break;
      case "Wants Children":
        ref.update({'Wants Children': user.getChildrenPreference});
        break;
      case "Hometown":
        ref.update({'Hometown': user.getHometown});
        break;
      case "Work":
        ref.update({'Work': user.getWork});
        break;
      case "Job Title":
        ref.update({'Job Title': user.getJobTitle});
        break;
      case "School":
        ref.update({'School': user.getSchool});
        break;
      case "Education Level":
        ref.update({'Education Level': user.getEducationLevel});
        break;
      case "Religion":
        ref.update({'Religion': user.getReligion});
        break;
      case "Political Belief":
        ref.update({'Political Belief': user.getPoliticalBelief});
        break;
      case "Alcohol Preference":
        ref.update({'Alcohol Preference': user.getAlcoholPreference});
        break;
      case "Smoking Preference":
        ref.update({'Smoking Preference': user.getSmokePreference});
        break;
      case "Drugs Preference":
        ref.update({'Drugs Preference': user.getDrugPreference});
        break;
      case "Weed Preference":
        ref.update({'Weed Preference': user.getWeedPreference});
        break;
      case "Personality Type":
        ref.update({'Personality Type': user.getPersonalityType});
        break;
      case "Liked User IDS":
        ref.update({'Liked User IDS': user.getLikedUserIDS});
        break;
      case "Disliked User IDS":
        ref.update({'Disliked User IDS': user.getDislikedUserIDS});
        break;
      case "Matched User IDS":
        ref.update({'Matched User IDS': user.getMatchedUserIDS});
        break;
    }

    return "Success";
  }
}
