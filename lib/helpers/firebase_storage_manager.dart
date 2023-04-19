import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
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
        var url = await imageRef.getDownloadURL();
        images[count] = await getImageXFileByUrl(url);
        count++;
      }
    });

    return images;
  }

  static Future<XFile> getImageXFileByUrl(String url) async {
    var file = await DefaultCacheManager().getSingleFile(url);
    XFile result = XFile(file.path);
    return result;
  }
}
