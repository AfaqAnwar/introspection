import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/data/custom_user.dart';

class DiscoveryManager {
  late CustomUser currentUser;
  late List<CustomUser> potentialMatches;

  DiscoveryManager(CustomUser givenUser) {
    currentUser = givenUser;
    potentialMatches = [];
  }

  void calculatePotentialMatches() {
    // Get reference(s) to Firestore collection.
    // Check if doc(s) exist for matching personality types.
    // If doc(s) exist, add the users with that ID to the potentialMatches list. *User FirebaseUserBuilder to build the CustomUser objects.*
    // If doc(s) do not exist, do nothing.
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
}
