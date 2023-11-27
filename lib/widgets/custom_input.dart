import 'package:chat_app/config/theme/apptext_theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomInput extends StatefulWidget {
  CustomInput({
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
  bool isPassword;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2, left: 2, bottom: 2, right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: widget.textController,
        autocorrect: false,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword,
        style: AppTextTheme.blackBody,
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.icon,
            color: Colors.grey.shade400,
          ),
          suffixIcon: widget.placeholder.contains('Contraseña')
              ? widget.isPassword
                  ? GestureDetector(
                      child: Icon(
                        Icons.remove_red_eye_outlined,
                        size: 20,
                        color: Colors.grey.shade400,
                      ),
                      onTap: () {
                        widget.isPassword = false;
                        setState(() {});
                      },
                    )
                  : GestureDetector(
                      child: Icon(
                        Icons.remove_red_eye,
                        size: 20,
                        color: Colors.grey.shade400,
                      ),
                      onTap: () {
                        widget.isPassword = true;
                        setState(() {});
                      },
                    )
              : null,
          hintText: widget.placeholder,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red.shade800),
          ),
        ),
      ),
    );
  }
}
