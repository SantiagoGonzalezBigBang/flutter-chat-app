import 'dart:convert';

import 'package:chat/models/models.dart';

class AuthResponseModel {

  AuthResponseModel({
    required this.ok,
    required this.userModel,
    required this.token,
  });

  bool ok;
  UserModel userModel;
  String token;

  factory AuthResponseModel.fromJson(String str) => AuthResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromMap(Map<String, dynamic> json) => AuthResponseModel(
    ok     : json["ok"],
    userModel: UserModel.fromMap(json["usuario"]),
    token  : json["token"],
  );

  Map<String, dynamic> toMap() => {
    "ok"     : ok,
    "usuario": userModel.toMap(),
    "token"  : token,
  };
}

class ErrorsModel {
  ErrorsModel({
    required this.ok,
    required this.errors,
  });

  bool ok;
  Errors errors;

  factory ErrorsModel.fromJson(String str) => ErrorsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ErrorsModel.fromMap(Map<String, dynamic> json) => ErrorsModel(
    ok: json["ok"],
    errors: Errors.fromMap(json["errors"]),
  );

  Map<String, dynamic> toMap() => {
    "ok": ok,
    "errors": errors.toMap(),
  };
}

class Errors {
  Errors({
    this.nombre,
    this.password,
    this.email,
  });

  ErrorModel? nombre;
  ErrorModel? password;
  ErrorModel? email;

  factory Errors.fromJson(String str) => Errors.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Errors.fromMap(Map<String, dynamic> json) => Errors(
    nombre: json["nombre"] == null ? null : ErrorModel.fromMap(json["nombre"]),
    password: json["password"] == null ? null : ErrorModel.fromMap(json["password"]),
    email: json["email"] == null ? null :  ErrorModel.fromMap(json["email"]),
  );

  Map<String, dynamic> toMap() => {
    "nombre": nombre?.toMap(),
    "password": password?.toMap(),
    "email": email?.toMap(),
  };
}

class ErrorModel {
  ErrorModel({
    required this.msg,
    required this.param,
    required this.location,
  });

  String msg;
  String param;
  String location;

  factory ErrorModel.fromJson(String str) => ErrorModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ErrorModel.fromMap(Map<String, dynamic> json) => ErrorModel(
    msg: json["msg"],
    param: json["param"],
    location: json["location"],
  );

  Map<String, dynamic> toMap() => {
    "msg": msg,
    "param": param,
    "location": location,
  };
}
