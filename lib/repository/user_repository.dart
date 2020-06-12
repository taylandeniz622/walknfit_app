import 'package:walknfitapp/locator.dart';
import 'package:walknfitapp/models/user.dart';
import 'package:walknfitapp/service/auth/firebase_auth.dart';
import 'package:walknfitapp/service/auth/firebase_base.dart';
import 'package:walknfitapp/service/auth/other_auth.dart';
import 'package:walknfitapp/service/firestore/firestore_service.dart';

enum AppMode { DEBUG, RELEASE }

class UserRepository implements AuthBase {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  OtherAuthService _fakeAuthService = locator<OtherAuthService>();
  FirestoreService _firestoreService = locator<FirestoreService>();

  AppMode appMode = AppMode.RELEASE;

  @override
  Future<User> currentUser() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.currentUser();
    } else {
      final _user = await _firebaseAuthService.currentUser();
      if (_user != null) {
        return await _firestoreService.readUserDatabase(_user.userID);
      } else {
        return null;
      }
    }
  }

  @override
  Future<bool> signOut() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signOut();
    } else {
      return await _firebaseAuthService.signOut();
    }
  }

  @override
  Future<User> singInAnonim() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.singInAnonim();
    } else {
      return await _firebaseAuthService.singInAnonim();
    }
  }

  @override
  Future<User> googleSignIn() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.googleSignIn();
    } else {
      final _user = await _firebaseAuthService.googleSignIn();
      bool sonuc = await _firestoreService.saveUserDatabase(_user);
      if (sonuc == true) {
        return await _firestoreService.readUserDatabase(_user.userID);
      } else
        return null;
    }
  }

  @override
  Future<User> createUserWithEmailandPassword(
      String email, String sifre) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.createUserWithEmailandPassword(
          email, sifre);
    } else {
      User _user = await _firebaseAuthService.createUserWithEmailandPassword(
          email, sifre);
      bool sonuc = await _firestoreService.saveUserDatabase(_user);
      if (sonuc == true) {
        return await _firestoreService.readUserDatabase(_user.userID);
      } else
        return null;
    }
  }

  @override
  Future<User> signInWithEmailandPassword(String email, String sifre) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signInWithEmailandPassword(email, sifre);
    } else {
      User _user =
          await _firebaseAuthService.signInWithEmailandPassword(email, sifre);
      return await _firestoreService.readUserDatabase(_user.userID);
    }
  }

  Future<bool> updateUsername(String userID, String yeniUserName) async {
    if (appMode == AppMode.DEBUG) {
      return false;
    } else {
      await _firestoreService.updateUsername(userID, yeniUserName);
      return true;
    }
  }

  @override
  Future<void> sifremiUnuttum(String email) async {
    if (appMode == AppMode.DEBUG) {
      return null;
    } else {
      return await _firebaseAuthService.sifremiUnuttum(email);
    }
  }
}
