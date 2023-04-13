import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/data/custom_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseManager {
  late CustomUser currentUser;

  FirebaseManager(CustomUser givenUser) {
    currentUser = givenUser;
  }

  CollectionReference getCollectionReference() {
    CollectionReference ref;

    if (currentUser.getGender == "Male") {
      ref = FirebaseFirestore.instance.collection('male users');
    } else {
      ref = FirebaseFirestore.instance.collection('female users');
    }
    return ref;
  }

  Future categorizeUser() async {
    CollectionReference ref = getCollectionReference();
    String personality = currentUser.getPersonalityType;

    await checkIfDocExists(personality).then((value) {
      if (value == false) {
        List<dynamic> users = [];
        users.add(FirebaseAuth.instance.currentUser!.uid);
        ref.doc(personality).set({
          'users': users,
        });
      } else {
        ref.doc(personality).update({
          'users':
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
        });
      }
    });
  }

  Future<bool> checkIfDocExists(String docId) async {
    try {
      // Get reference to Firestore collection
      CollectionReference collectionRef = getCollectionReference();

      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }
}
