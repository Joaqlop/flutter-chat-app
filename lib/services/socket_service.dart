// ignore_for_file: constant_identifier_names, library_prefixes

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/services/auth_service.dart';

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  void connect() async {
    final token = await AuthService.getToken();

    // Dart client

    _socket = IO.io(
      Enviroment.socketUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .enableForceNew()
          .setExtraHeaders({'x-token': token})
          .build(),
    );

    _socket.onConnect((_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  void disconnect() {
    _socket.disconnect();
  }
}
