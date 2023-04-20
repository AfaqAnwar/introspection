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
    }

    return "Success";
  }
}
