import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/data/current_user.dart';

class DiscoveryManager {
  late CurrentUser currentUser;

  DiscoveryManager(CurrentUser givenUser) {
    currentUser = givenUser;
  }

  List<CollectionReference> getCollectionReferences() {
    List<CollectionReference> refs = [];

    if (currentUser.getGenderPreference == "female") {
      CollectionReference ref =
          FirebaseFirestore.instance.collection('female users');
      refs.add(ref);
    } else if (currentUser.genderPreference == "male") {
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
