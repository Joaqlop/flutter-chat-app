import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat_app/services/services.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final auth = await authService.isLogged();

    if (auth) {
      // Connect SocketServer
      socketService.connect();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, 'users');
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}
