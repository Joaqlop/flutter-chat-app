// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/helpers/helpers.dart';
import 'package:chat_app/services/services.dart';
import 'package:chat_app/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Logo(),
                const _Form(),
                Labels(
                  account: '¿No tenés una cuenta? ',
                  action: 'Creá una :)',
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, 'register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form();

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          CustomInput(
            placeholder: 'Email',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          const SizedBox(height: 20),
          CustomInput(
            placeholder: 'Contraseña',
            icon: Icons.key,
            keyboardType: TextInputType.text,
            textController: passwordCtrl,
            isPassword: true,
          ),
          const SizedBox(height: 20),
          BlueButton(
            placeholder: 'Ingresar',
            onPressed: authService.auth
                ? () {}
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginSuccess = await authService.login(
                      emailCtrl.text.trim(),
                      passwordCtrl.text.trim(),
                    );

                    if (loginSuccess) {
                      socketService.connect();
                      Navigator.pushReplacementNamed(context, 'users');
                    } else {
                      showAlert(context, 'Login Incorrecto', 'Revisar datos');
                    }
                  },
          ),
        ],
      ),
    );
  }
}
