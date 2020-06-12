import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:walknfitapp/models/user.dart';

import 'firestore_base.dart';

class FirestoreService implements DBBase {
  Firestore _firestore = Firestore.instance;

  @override
  Future<bool> saveUserDatabase(User user) async {
    DocumentSnapshot _okunanUser =
        await _firestore.collection('users').document(user.userID).get();
    if (_okunanUser.data == null) {
      await _firestore
          .collection('users')
          .document(user.userID)
          .setData(user.toMap());
      return true;
    } else {
      return true;
    }
  }

  @override
  Future<User> readUserDatabase(String userID) async {
    DocumentSnapshot _okunanUser =
        await _firestore.collection('users').document(userID).get();
    Map<String, dynamic> _okunanUserMap = _okunanUser.data;
    User _okunanUserBilgileri = User.fromMap(_okunanUserMap);
    print('okunanUser' + _okunanUserBilgileri.toString());
    return _okunanUserBilgileri;
  }

  @override
  Future<bool> updateUsername(String userID, String yeniUsername) async {
    var users = await _firestore
        .collection('users')
        .where('userName', isEqualTo: yeniUsername)
        .getDocuments();
    if (users.documents.length >= 1) {
      return false;
    } else {
      await _firestore
          .collection('users')
          .document(userID)
          .updateData({'userName': yeniUsername});
      return true;
    }
  }
}
