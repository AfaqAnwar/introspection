import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageManager {
  late String userID;

  FirebaseStorageManager(String givenID) {
    userID = givenID;
  }

  Future<Map<int, XFile>> getImages() async {
    final storageRef = FirebaseStorage.instance.ref();
    String path = "users/$userID";
    final pathReference = storageRef.child(path);

    Map<int, XFile> images = {};

    await pathReference.listAll().then((result) async {
      int count = 0;
      for (var imageRef in result.items) {
        await imageRef.getData().then((value) {
          images[count] = XFile.fromData(value!);
          count++;
        });
      }
    });

    return images;
  }
}
