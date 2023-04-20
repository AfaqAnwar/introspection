import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/helpers/firebase_user_builder.dart';
import 'package:flutter/services.dart';

class DiscoveryManager {
  late CustomUser currentUser;
  late List<String> idsOfPotentialMatches;
  late List<CustomUser> potentialMatches;

  DiscoveryManager(CustomUser givenUser) {
    currentUser = givenUser;
    idsOfPotentialMatches = [];
    potentialMatches = [];
  }

  Future discover() async {
    // Get reference(s) to Firestore collection.
    // Check if doc(s) exist for matching personality types.
    // If doc(s) exist, add the users with that ID to the potentialMatches list. *User FirebaseUserBuilder to build the CustomUser objects.*
    // If doc(s) do not exist, do nothing.
    List<String> compatiblePersonalities = await findCompatibleMatchesFromMap();
    List<CollectionReference> poolOfInterests = getCollectionReferences();

    for (int i = 0; i < poolOfInterests.length; i++) {
      await poolOfInterests[i].get().then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          String personalityType = doc.id;
          if (compatiblePersonalities.contains(personalityType)) {
            for (var id in doc.get("users")) {
              if (!hasAlreadyBeenSeen(id) && id != currentUser.getUid) {
                idsOfPotentialMatches.add(id);
              }
            }
          }
        }
      });
    }

    await buildUsers(idsOfPotentialMatches);
  }

  bool hasAlreadyBeenSeen(String id) {
    return (currentUser.getLikedUserIDS.contains(id) ||
        currentUser.getDislikedUserIDS.contains(id) ||
        currentUser.getMatchedUserIDS.contains(id));
  }

  Future<List<String>> findCompatibleMatchesFromMap() async {
    Map<String, dynamic> possibleMatches = {};

    final String response =
        await rootBundle.loadString('assets/data/compatibility_map.json');

    final data = await json.decode(response);

    possibleMatches = data[currentUser.getPersonalityType];
    possibleMatches.remove("2");
    possibleMatches.remove("1");

    List<String> finalCompatibleMatches = [];
    for (var key in possibleMatches.keys) {
      for (var type in possibleMatches[key]) {
        finalCompatibleMatches.add(type);
      }
    }

    return finalCompatibleMatches;
  }

  Future buildUsers(List<String> ids) async {
    if (ids.isNotEmpty) {
      for (int i = 0; i < ids.length; i++) {
        FirebaseUserBuilder builder = FirebaseUserBuilder(ids[i]);
        CustomUser user = await builder.buildUser();
        potentialMatches.add(user);
      }
    }
  }

  List<CollectionReference> getCollectionReferences() {
    List<CollectionReference> refs = [];

    if (currentUser.getGenderPreference == "Women") {
      CollectionReference ref =
          FirebaseFirestore.instance.collection('female users');
      refs.add(ref);
    } else if (currentUser.genderPreference == "Men") {
      CollectionReference ref =
          FirebaseFirestore.instance.collection('male users');
      refs.add(ref);
    } else {
      CollectionReference refFirst =
          FirebaseFirestore.instance.collection('female users');
      CollectionReference refSecond =
          FirebaseFirestore.instance.collection('male users');
      refs.add(refFirst);
      refs.add(refSecond);
    }

    return refs;
  }

  Future<List<bool>> checkIfDocExists(String docId) async {
    List<bool> results = [];
    try {
      // Get reference to Firestore collection
      List<CollectionReference> collectionRef = getCollectionReferences();
      for (int i = 0; i < collectionRef.length; i++) {
        var doc = await collectionRef[i].doc(docId).get();
        results.add(doc.exists);
      }
      return results;
    } catch (e) {
      return results;
    }
  }

  List<CustomUser> getPotentialMatches() {
    return potentialMatches;
  }

  List<String> getPotentialMatchesIds() {
    return idsOfPotentialMatches;
  }
}
