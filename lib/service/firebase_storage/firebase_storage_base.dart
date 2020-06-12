import 'dart:io';

abstract class FirebaseStoreageBase {
  Future<String> uploadFile(String foodID, String kategoriID, File foodFile);
}
