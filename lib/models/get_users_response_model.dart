import 'dart:convert';

import 'package:chat/models/models.dart';

class GetUsersResponseModel {
  GetUsersResponseModel({
    required this.ok,
    required this.users,
  });

  bool ok;
  List<UserModel> users;

  factory GetUsersResponseModel.fromJson(String str) => GetUsersResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetUsersResponseModel.fromMap(Map<String, dynamic> json) => GetUsersResponseModel(
    ok   : json["ok"],
    users: List<UserModel>.from(json["usuarios"].map((x) => UserModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "ok"      : ok,
    "usuarios": List<dynamic>.from(users.map((x) => x.toMap())),
  };
}