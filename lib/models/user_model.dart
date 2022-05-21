// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'dart:convert';

class UserModel {

  UserModel({
    required this.name,
    required this.email,
    required this.isOnline,
    required this.uid,
  });

  String name;
  String email;
  bool isOnline;
  String uid;

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    name    : json["nombre"],
    email   : json["email"],
    isOnline: json["isOnline"],
    uid     : json["uid"],
  );

  Map<String, dynamic> toMap() => {
    "nombre"  : name,
    "email"   : email,
    "isOnline": isOnline,
    "uid"     : uid,
  };
}
