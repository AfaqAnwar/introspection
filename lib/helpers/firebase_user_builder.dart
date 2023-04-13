import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/data/custom_user.dart';

class FirebaseUserBuilder {
  late String userID;

  FirebaseUserBuilder(String givenUserID) {
    userID = givenUserID;
  }

  Future<CustomUser> buildUser() async {
    CustomUser user = CustomUser();
    CollectionReference ref = getCollectionReference();

    checkIfDocExists(userID).then((value) => () async {
          DocumentSnapshot data = await ref.doc(userID).get();
          user.setFirstName = data.get('First Name');
          user.setLastName = data.get('Last Name');
          user.setEmail = data.get('Email');
          user.setDob = data.get('DOB');
          user.setZipcode = data.get('Zip Code');
          user.setCity = data.get('City');
          user.setState = data.get('State');
          user.setCountry = data.get('Country');
          user.setGender = data.get('Gender');
          user.setGenderPreference = data.get('Gender Preference');
          user.setHeight = data.get('Height');
          user.setEthnicities = decodeDynamicList(data.get('Ethnicities'));
          user.setHasChildren = data.get('Has Children');
          user.setChildrenPreference = data.get('Wants Children');
          user.setHometown = data.get('Hometown');
          user.setWork = data.get('Work');
          user.setJobTitle = data.get('Job Title');
          user.setSchool = data.get('School');
          user.setEducationLevel = data.get('Education Level');
          user.setReligion = data.get('Religion');
          user.setPoliticalBelief = data.get('Political Belief');
          user.setAlcoholPreference = data.get('Alcohol Preference');
          user.setSmokePreference = data.get('Smoking Preference');
          user.setDrugPreference = data.get('Drugs Preference');
          user.setPersonalityType = data.get('Personality Type');
          return user;
        });
    return user;
  }

  CollectionReference getCollectionReference() {
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    return ref;
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

  List<String> decodeDynamicList(List<dynamic> data) {
    List<String> ethnicities = [];
    for (int i = 0; i < data.length; i++) {
      ethnicities.add(data[i].toString());
    }
    return ethnicities;
  }
}
