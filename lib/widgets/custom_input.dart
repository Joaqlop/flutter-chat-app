import 'package:chat_app/config/theme/apptext_theme.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    required this.keyboardType,
    required this.placeholder,
    required this.icon,
    required this.textController,
    this.isPassword = false,
  });

  final TextEditingController textController;
  final TextInputType keyboardType;
  final String placeholder;
  final IconData icon;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 3),
              blurRadius: 5,
            ),
          ]),
      child: TextField(
        controller: textController,
        autocorrect: false,
        keyboardType: keyboardType,
        obscureText: isPassword,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.grey.shade400,
            ),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: placeholder,
            hintStyle:
                AppTextTheme.greyBody?.copyWith(color: Colors.grey.shade400)),
      ),
    );
  }
}
