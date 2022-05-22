import 'package:chat/global/environment.dart';
import 'package:chat/services/services.dart';
import 'package:http/http.dart' as http;

import 'package:chat/models/models.dart';

class GetUsersService {

  Future<List<UserModel>> getUsers() async {
    try {
      
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/usuarios'), 
        headers: {
          'Content-Type' : 'application/json',
          'x-token' : await AuthService.getToken() ?? ''
        }
      );

      final getUsersResponseModel = GetUsersResponseModel.fromJson(response.body);

      return getUsersResponseModel.users;
      
    } catch (e) {
      return [];
    }
  }

}