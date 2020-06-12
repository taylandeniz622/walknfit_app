import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Besin {
  final String foodID;
  String title;
  String desc;
  DateTime createAt;
  DateTime updateAt;
  String photoUrl;
  int kategoriId;

  Besin({@required this.foodID, this.title});

  Map<String, dynamic> toMap() {
    return {
      'foodID': foodID,
      'title': title,
      'desc': desc,
      'createAt': createAt ?? FieldValue.serverTimestamp(),
      'updateAt': updateAt ?? FieldValue.serverTimestamp(),
      'photoUrl': photoUrl ?? '',
      'kategoriId': kategoriId ?? '1',
    };
  }

  Besin.fromMap(Map<String, dynamic> map)
      : foodID = map['foodID'],
        title = map['title'],
        desc = map['desc'],
        createAt = (map['createAt'] as Timestamp).toDate(),
        updateAt = (map['updateAt'] as Timestamp).toDate(),
        photoUrl = map['photoUrl'],
        kategoriId = map['kategoriId'];
}
