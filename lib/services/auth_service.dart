import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import 'package:chat/models/models.dart';
import 'package:chat/global/environment.dart';

class AuthService with ChangeNotifier {

  UserModel? userModel;
  bool _isAuthenticating = false;
  final _flutterSecureStorage = const FlutterSecureStorage();

  bool get isAuthenticating => _isAuthenticating;
  set isAuthenticating(bool value) {
    _isAuthenticating = value;
    notifyListeners();
  }

  //* Static Getters
  static Future<String?> getToken() async {
    const flutterSecureStorage = FlutterSecureStorage();
    final token = await flutterSecureStorage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    const flutterSecureStorage = FlutterSecureStorage();
    await flutterSecureStorage.delete(key: 'token');
  }

  Future<bool> login({required String email, required String password}) async {

    isAuthenticating = true;

    final data = {
      'email'    : email,
      'password' : password
    };

    final response = await http.post(
      Uri.parse('${Environment.apiUrl}/login'), 
      body: jsonEncode(data),
      headers: {
        'Content-Type' : 'application/json'
      }
    );

    if (response.statusCode == 200) {
      final authResponseModel = AuthResponseModel.fromJson(response.body);
      userModel = authResponseModel.userModel; 

      await _saveToken(authResponseModel.token);
    } else {
      userModel = null;
    }

    isAuthenticating = false;

    return userModel != null ? true : false;
  }

  Future register({required String name, required String email, required String password}) async {
    isAuthenticating = true;

    final data = {
      'nombre'   : name,
      'email'    : email,
      'password' : password
    };

    final response = await http.post(
      Uri.parse('${Environment.apiUrl}/login/new'), 
      body: jsonEncode(data),
      headers: {
        'Content-Type' : 'application/json'
      }
    );

    final responseBody = jsonDecode(response.body);
    String? errorString = '';
    
    if (response.statusCode == 200) {
      final authResponseModel = AuthResponseModel.fromJson(response.body);
      userModel = authResponseModel.userModel; 

      await _saveToken(authResponseModel.token);
    } else {
      userModel = null;
      if (responseBody['msg'] != null) {
        errorString = responseBody['msg'];
      } else {
        final errorModel = ErrorsModel.fromJson(response.body);
        errorString += errorModel.errors.nombre   != null ? '\n${errorModel.errors.nombre?.msg}'   : '';
        errorString += errorModel.errors.email    != null ? '\n${errorModel.errors.email?.msg}'    : '';
        errorString += errorModel.errors.password != null ? '\n${errorModel.errors.password?.msg}' : '';
      }
    }

    isAuthenticating = false;

    return userModel != null ? true : errorString;
  }

  Future<bool> isLoggedIn() async {

    final token = await _flutterSecureStorage.read(key: 'token');

    if (token != null) {


      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/login/renew'),
        headers: {
          'Content-Type' : 'application/json',
          'x-token' : token
        }
      );

      if (response.statusCode == 200) {
        final authResponseModel = AuthResponseModel.fromJson(response.body);
        userModel = authResponseModel.userModel;
        await _saveToken(authResponseModel.token);

        return true;
      } else {
        logout();
        return false;
      }


    } else {
      return false;
    }

  }

  Future _saveToken(String token) async {
    return await _flutterSecureStorage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _flutterSecureStorage.delete(key: 'token');
  }

}