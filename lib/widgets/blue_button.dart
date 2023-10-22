import 'package:chat_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/config/theme/apptext_theme.dart';
import 'package:provider/provider.dart';

class BlueButton extends StatelessWidget {
  const BlueButton({key, required this.placeholder, required this.onPressed})
      : super(key: key);

  final Function() onPressed;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return MaterialButton(
      elevation: 0,
      highlightElevation: 5,
      color: Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onPressed: onPressed,
      child: SizedBox(
        width: 100,
        height: 50,
        child: authService.auth
            ? const Center(
                child: LinearProgressIndicator(
                  backgroundColor: Colors.blueAccent,
                  color: Colors.white,
                  minHeight: 3,
                ),
              )
            : Center(
                child: Text(placeholder, style: AppTextTheme.whiteButton),
              ),
      ),
    );
  }
}
