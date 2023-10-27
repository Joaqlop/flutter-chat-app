import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/models.dart';
import 'package:chat_app/services/services.dart';

class ChatService with ChangeNotifier {
  late User userTo;

  Future<List<Message>> getChat(String userId) async {
    final uri = Uri.parse('${Enviroment.apiUrl}/messages/$userId');
    final token = await AuthService.getToken();

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'x-token': token ?? '',
      },
    );

    final chatMessages = messagesResponseFromJson(response.body);
    return chatMessages.messages;
  }
}
