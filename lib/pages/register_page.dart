// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/config/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat_app/helpers/alert.dart';
import 'package:chat_app/services/services.dart';
import 'package:chat_app/widgets/widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Logo(),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: Text(
                    'Creá tu cuenta',
                    style: AppTextTheme.greyTitle,
                  ),
                ),
                const _Form(),
                const SizedBox(height: 20),
                Labels(
                  account: '¿Ya tenés cuenta? ',
                  action: 'Ingresá',
                  onTap: () => Navigator.pushReplacementNamed(context, 'login'),
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
  final passwordCtrl2 = TextEditingController();
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          CustomInput(
            placeholder: 'Nombre',
            icon: Icons.perm_identity,
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),
          const SizedBox(height: 20),
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
          CustomInput(
            placeholder: 'Repetir Contraseña',
            icon: Icons.key,
            keyboardType: TextInputType.text,
            textController: passwordCtrl2,
            isPassword: true,
          ),
          const SizedBox(height: 20),
          BlueButton(
            placeholder: 'Registrate',
            onPressed: authService.auth
                ? () {}
                : () async {
                    FocusScope.of(context).unfocus();
                    final registerSuccess = await authService.register(
                      nameCtrl.text.trim(),
                      emailCtrl.text.trim(),
                      passwordCtrl.text.trim(),
                    );

                    if (registerSuccess) {
                      socketService.connect();
                      Navigator.pushReplacementNamed(context, 'users');
                    } else {
                      if (emailCtrl.text.isEmpty) {
                        showAlert(
                          context,
                          'Error',
                          'Completá los campos requeridos',
                        );
                      } else {
                        showAlert(
                          context,
                          'Error',
                          'El correo electrónico ya se encuentra registrado.',
                        );
                      }
                    }
                  },
          ),
        ],
      ),
    );
  }
}
