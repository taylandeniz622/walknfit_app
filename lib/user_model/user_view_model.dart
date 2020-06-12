import 'package:flutter/material.dart';
import 'package:walknfitapp/locator.dart';
import 'package:walknfitapp/models/user.dart';
import 'package:walknfitapp/repository/user_repository.dart';
import 'package:walknfitapp/service/auth/firebase_base.dart';

enum DurumState { Idle, Busy }

class UserModel extends ChangeNotifier implements AuthBase {
  DurumState _state;
  UserRepository _repository = locator<UserRepository>();
  User _user;
  String emailHataMesaji;
  String sifreHataMesaji;

  DurumState get state => _state;

  User get user => _user;

  set user(User value) {
    _user = value;
    notifyListeners();
  }

  set state(DurumState value) {
    _state = value;
    notifyListeners();
  }

  UserModel() {
    currentUser();
  }

  @override
  Future<User> currentUser() async {
    try {
      state = DurumState.Busy;
      User _user = await _repository.currentUser();
      if (_user != null) {
        return _user;
      } else
        return null;
    } catch (e) {
      debugPrint('UserView CurrentUser Hata' + e.toString());
      return null;
    } finally {
      state = DurumState.Idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = DurumState.Busy;
      bool sonuc = await _repository.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      debugPrint('UserView SignOut Hata' + e.toString());
      return false;
    } finally {
      state = DurumState.Idle;
    }
  }

  @override
  Future<User> singInAnonim() async {
    try {
      state = DurumState.Busy;
      _user = await _repository.singInAnonim();
      return _user;
    } catch (e) {
      debugPrint('UserView Anonim Hata' + e.toString());
      return null;
    } finally {
      state = DurumState.Idle;
    }
  }

  @override
  Future<User> googleSignIn() async {
    try {
      state = DurumState.Busy;
      _user = await _repository.googleSignIn();
      if (_user != null)
        return _user;
      else
        return null;
    } catch (e) {
      debugPrint('UserView GoogleSign Hata' + e.toString());
      return null;
    } finally {
      state = DurumState.Idle;
    }
  }

  @override
  Future<User> createUserWithEmailandPassword(
      String email, String sifre) async {
    if (_emailSifreHata(email, sifre)) {
      try {
        state = DurumState.Busy;
        _user = await _repository.createUserWithEmailandPassword(email, sifre);
        return _user;
      } finally {
        state = DurumState.Idle;
      }
    } else
      return null;
  }

  @override
  Future<User> signInWithEmailandPassword(String email, String sifre) async {
    if (_emailSifreHata(email, sifre)) {
      try {
        state = DurumState.Busy;
        User _user = await _repository.signInWithEmailandPassword(email, sifre);
        return _user;
      } finally {
        state = DurumState.Idle;
      }
    } else
      return null;
  }

  bool _emailSifreHata(String email, String sifre) {
    var sonuc = true;
    if (!email.contains('@')) {
      emailHataMesaji = 'Geçersiz email';
      sonuc = false;
    } else {
      emailHataMesaji = null;
    }
    if (sifre.length < 6) {
      sifreHataMesaji = 'En az 6 karakter';
      sonuc = false;
    } else {
      sifreHataMesaji = null;
    }
    return sonuc;
  }

  Future<bool> updateUsername(String userID, String yeniUserName) async {
    var sonuc = await _repository.updateUsername(userID, yeniUserName);
    if (sonuc) {
      _user.userName = yeniUserName;
    }
    return sonuc;
  }

  @override
  Future<void> sifremiUnuttum(String email) async {
    return await _repository.sifremiUnuttum(email);
  }
}
