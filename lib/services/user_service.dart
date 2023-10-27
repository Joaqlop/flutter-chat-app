import 'package:http/http.dart' as http;

import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/models.dart';
import 'package:chat_app/services/services.dart';

class UserService {
  Future<List<User>> getUsers() async {
    try {
      final token = await AuthService.getToken();
      final uri = Uri.parse('${Enviroment.apiUrl}/users');

      final response = await http.get(
        uri,
        headers: {
          'Content-type': 'application/json',
          'x-token': token!,
        },
      );

      final userListResponse = userListResponseFromJson(response.body);

      return userListResponse.userList;
    } catch (e) {
      return [];
    }
  }
}
