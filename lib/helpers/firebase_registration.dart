import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/data/custom_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class FirebaseRegistrationHelper {
  late CustomUser currentUser;

  FirebaseRegistrationHelper(CustomUser givenUser) {
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
      'uid': FirebaseAuth.instance.currentUser!.uid,
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
      'Weed Preference': currentUser.getWeedPreference,
      'Personality Type': currentUser.getPersonalityType,
      'Liked User IDS': [],
      'Disliked User IDS': [],
      'Matched User IDS': [],
    });
  }

  Future<String> uploadUserImages() async {
    try {
      FirebaseStorage firebaseStorage = FirebaseStorage.instance;
      for (int i = 0; i < currentUser.getImages.length; i++) {
        if (currentUser.getImages[i] != null) {
          File file = File(currentUser.getImages[i]!.path);
          await firebaseStorage
              .ref('users/${FirebaseAuth.instance.currentUser!.uid}/ $i')
              .putFile(file);
        }
      }
      return "Success";
    } catch (error) {
      return error.toString();
    }
  }

  Future<String> addToChatCore() async {
    await FirebaseChatCore.instance.createUserInFirestore(types.User(
      firstName: currentUser.getFirstName,
      id: "chat${currentUser.getUid}",
      imageUrl: FirebaseStorage.instance
          .ref('users/${FirebaseAuth.instance.currentUser!.uid}/0')
          .fullPath,
      lastName: currentUser.getLastName,
    ));
    return "Success";
  }
}
