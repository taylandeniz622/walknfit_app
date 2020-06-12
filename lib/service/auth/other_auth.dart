import 'package:walknfitapp/models/user.dart';
import 'package:walknfitapp/service/auth/firebase_base.dart';

class OtherAuthService implements AuthBase {
  String userID = '123456789';
  String email = 'taylan@taylan.com';

  @override
  Future<User> currentUser() async {
    return await Future.value(User(userID: userID, email: email));
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  @override
  Future<User> singInAnonim() async {
    return await Future.delayed(
        Duration(seconds: 2), () => User(userID: userID, email: email));
  }

  @override
  Future<User> googleSignIn() async {
    return await Future.delayed(Duration(seconds: 2),
        () => User(userID: 'google_user_123456', email: email));
  }

  /*@override
  Future<User> facebookLogin() async {
    return await Future.delayed(
        Duration(seconds: 2), () => User(userID: 'facebook_user_123456',email: email));
  }*/

  @override
  Future<User> createUserWithEmailandPassword(
      String email, String sifre) async {
    return await Future.delayed(Duration(seconds: 2),
        () => User(userID: 'create_user_123456', email: email));
  }

  @override
  Future<User> signInWithEmailandPassword(String email, String sifre) async {
    return await Future.delayed(Duration(seconds: 2),
        () => User(userID: 'sign_user_123456', email: email));
  }

  @override
  Future<void> sifremiUnuttum(String email) async {
    return await Future.delayed(Duration(seconds: 2),
        () => User(userID: 'sign_user_123456', email: email));
  }
}
