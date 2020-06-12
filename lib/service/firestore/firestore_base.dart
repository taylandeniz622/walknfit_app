import 'package:walknfitapp/models/user.dart';

abstract class DBBase {
  Future<bool> saveUserDatabase(User user);
  Future<User> readUserDatabase(String userID);
  Future<bool> updateUsername(String userID, String yeniUsername);
}
