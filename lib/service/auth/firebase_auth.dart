import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:walknfitapp/models/user.dart';
import 'package:walknfitapp/service/auth/firebase_base.dart';

class FirebaseAuthService implements AuthBase {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User> currentUser() async {
    try {
      FirebaseUser user = await _firebaseAuth.currentUser();
      print(user.email);
      return _userFromFirebase(user);
    } catch (e) {
      print('Hata current user ' + e.toString());
      return null;
    }
  }

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    } else {
      return User(userID: user.uid, email: user.email);
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      final _googleSignIn = GoogleSignIn();
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print('Hata signOut' + e.toString());
      return false;
    }
  }

  @override
  Future<User> singInAnonim() async {
    try {
      AuthResult sonuc = await _firebaseAuth.signInAnonymously();
      return _userFromFirebase(sonuc.user);
    } catch (e) {
      print('Hata anonim ' + e.toString());
      return null;
    }
  }

  @override
  Future<User> googleSignIn() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount _googleuser = await _googleSignIn.signIn();
    if (_googleuser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleuser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        AuthResult sonuc = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.getCredential(
                accessToken: _googleAuth.accessToken,
                idToken: _googleAuth.idToken));
        FirebaseUser _user = sonuc.user;
        return _userFromFirebase(_user);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<User> createUserWithEmailandPassword(
      String email, String sifre) async {
    AuthResult sonuc = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: sifre);
    return _userFromFirebase(sonuc.user);
  }

  @override
  Future<User> signInWithEmailandPassword(String email, String sifre) async {
    AuthResult sonuc = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: sifre);
    return _userFromFirebase(sonuc.user);
  }

  @override
  Future<void> sifremiUnuttum(String email) async {
    try {
      return await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }
}
