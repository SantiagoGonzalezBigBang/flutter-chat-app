import 'package:chat/services/services.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:chat/models/models.dart';
import 'package:chat/global/environment.dart';

class ChatService with ChangeNotifier {
  
  UserModel? userModel;

  Future<List<Mensaje>> getChat(String userId) async {
    final response = await http.get(
      Uri.parse('${Environment.apiUrl}/mensajes/$userId'), 
      headers: {
        'Content-Type' : 'application/json',
        'x-token' : await AuthService.getToken() ?? ''
      }
    );

    final getMensajesResponseModel = GetMensajesResponseModel.fromJson(response.body);

    return getMensajesResponseModel.mensajes;

  }

}