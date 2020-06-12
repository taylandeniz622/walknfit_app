import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String userID;
  String email;
  String userName;
  DateTime createdAt;
  DateTime updatedAt;
  String profileUrl;
  String seviye;
  int age;
  int weight;
  int height;
  bool sex;

  User({@required this.userID, @required this.email});

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'email': email,
      'userName': userName ??
          email.substring(0, email.indexOf('@')) + rastgeleSayiUret(),
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': updatedAt ?? FieldValue.serverTimestamp(),
      'profileUrl': profileUrl ??
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSDgTNKTeE985pM29w_MVlLv6Q6zXuK8qHKq4O0pcB_aWH4JbQV&usqp=CAU',
      'seviye': seviye ?? '1',
      'age' : age,
      'weight' : weight,
      'height':height,
      'sex':sex,
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        email = map['email'],
        userName = map['userName'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        updatedAt = (map['updatedAt'] as Timestamp).toDate(),
        profileUrl = map['profileUrl'],
        seviye = map['seviye'],
        age = map['age'],
        weight = map['weight'],
        height = map['height'],
        sex = map['sex'];


  @override
  String toString() {
    return 'User{userID: $userID, email: $email, userName: $userName, createdAt: $createdAt, updatedAt: $updatedAt, profileUrl: $profileUrl, seviye: $seviye}';
  }

  String rastgeleSayiUret() {
    int rastgeleSayi = Random().nextInt(99999999);
    return rastgeleSayi.toString();
  }
}
