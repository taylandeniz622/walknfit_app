import 'dart:io';
import 'package:walknfitapp/locator.dart';

import 'package:walknfitapp/service/firebase_storage/firebase_storage_base.dart';
import 'package:walknfitapp/service/firebase_storage/firebase_storage_service.dart';

enum AppMode { DEBUG, RELEASE }

class FoodRepository implements FirebaseStoreageBase {
  AppMode appMode = AppMode.RELEASE;
  FirebaseStorageService _firestoreService = locator<FirebaseStorageService>();

  @override
  Future<String> uploadFile(
      String foodID, String kategoriID, File foodFile) async {
    if (appMode == AppMode.DEBUG) {
      return 'dosya_url';
    } else {
      return await _firestoreService.uploadFile(foodID, kategoriID, foodFile);
    }
  }
}
