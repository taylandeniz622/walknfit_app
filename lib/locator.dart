import 'package:get_it/get_it.dart';
import 'package:walknfitapp/repository/food_repository.dart';
import 'package:walknfitapp/repository/user_repository.dart';
import 'package:walknfitapp/service/auth/firebase_auth.dart';
import 'package:walknfitapp/service/auth/other_auth.dart';
import 'package:walknfitapp/service/firebase_storage/firebase_storage_service.dart';
import 'package:walknfitapp/service/firestore/firestore_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => OtherAuthService());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => FoodRepository());
  locator.registerLazySingleton(() => FirebaseStorageService());
}
