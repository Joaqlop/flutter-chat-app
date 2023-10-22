import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/models/models.dart';
import '../global/enviroment.dart';

class AuthService with ChangeNotifier {
  User? user;
  bool _auth = false;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  bool get auth => _auth;
  set auth(bool value) {
    _auth = value;
    notifyListeners();
  }

  static Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    auth = true;

    final data = {
      'email': email,
      'password': password,
    };

    final uri = Uri.parse('${Enviroment.apiUrl}/login');

    final response = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    auth = false;

    if (response.statusCode == 200) {
      final loginResponse = loginResponseFromJson(response.body);
      user = loginResponse.user;
      await _saveToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    auth = true;

    final data = {
      'name': name,
      'email': email,
      'password': password,
    };

    final uri = Uri.parse('${Enviroment.apiUrl}/login/new');

    final response = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    auth = false;

    if (response.statusCode == 200) {
      final registerResponse = registerResponseFromJson(response.body);
      user = registerResponse.user;
      await _saveToken(registerResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isLogged() async {
    final token = await _storage.read(key: 'token');

    final uri = Uri.parse('${Enviroment.apiUrl}/login/renew');

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'x-token': token ?? '',
      },
    );

    if (response.statusCode == 200) {
      final registerResponse = registerResponseFromJson(response.body);
      user = registerResponse.user;
      await _saveToken(registerResponse.token);
      return true;
    } else {
      deleteToken();
      return false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }
}
