import 'package:flutter/material.dart';
import 'package:chat_app/config/theme/apptext_theme.dart';

class BlueButton extends StatelessWidget {
  const BlueButton({key, required this.placeholder, required this.onPressed})
      : super(key: key);

  final Function() onPressed;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      highlightElevation: 5,
      color: Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onPressed: onPressed,
      child: SizedBox(
        width: 100,
        height: 50,
        child: Center(
          child: Text(placeholder, style: AppTextTheme.whiteButton),
        ),
      ),
    );
  }
}
