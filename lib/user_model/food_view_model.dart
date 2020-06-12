import 'dart:io';
import 'package:flutter/material.dart';
import 'package:walknfitapp/locator.dart';
import 'package:walknfitapp/models/besin.dart';
import 'package:walknfitapp/repository/food_repository.dart';
import 'package:walknfitapp/service/firebase_storage/firebase_storage_base.dart';

enum DurumState { Idle, Busy }

class FoodModel extends ChangeNotifier implements FirebaseStoreageBase {
  DurumState _state;
  Besin _food;
  FoodRepository _foodrepository = locator<FoodRepository>();

  DurumState get state => _state;

  set state(DurumState value) {
    _state = value;
    notifyListeners();
  }

  Besin get food => _food;

  set food(Besin value) => _food = value;

  @override
  Future<String> uploadFile(
      String foodID, String kategoriID, File foodFile) async {
    var sonuc = await _foodrepository.uploadFile(foodID, kategoriID, foodFile);
    if (sonuc != null) {
      return sonuc;
    } else
      return 'hata';
  }
}
