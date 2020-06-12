import 'package:walknfitapp/models/user.dart';

abstract class AuthBase {
  Future<User> currentUser();
  Future<User> singInAnonim();
  Future<bool> signOut();
  Future<User> googleSignIn();
  Future<User> signInWithEmailandPassword(String email, String sifre);
  Future<User> createUserWithEmailandPassword(String email, String sifre);
  Future<void> sifremiUnuttum(String email);
}
