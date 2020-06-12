import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:walknfitapp/service/firebase_storage/firebase_storage_base.dart';

class FirebaseStorageService implements FirebaseStoreageBase {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  StorageReference _storageRef;

  @override
  Future<String> uploadFile(
      String foodID, String kategoriID, File foodFile) async {
    _storageRef = _firebaseStorage
        .ref()
        .child(kategoriID)
        .child(foodID)
        .child('food_photo.png');

    var uploadTask = _storageRef.putFile(foodFile);
    var url = await (await uploadTask.onComplete).ref.getDownloadURL();
    return url;
  }
}
