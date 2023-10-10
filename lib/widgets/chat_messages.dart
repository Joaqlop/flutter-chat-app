import 'package:chat_app/config/theme/apptext_theme.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  final String text;
  final String uid;
  final AnimationController animationController;

  const ChatMessages(
      {super.key,
      required this.text,
      required this.uid,
      required this.animationController});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.elasticInOut,
        ),
        child: Container(
          child: uid == '123' ? _myMessage() : _notMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 5, right: 10),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(text, style: AppTextTheme.whiteButton),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 5, left: 10),
        decoration: BoxDecoration(
          color: const Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(text,
            style: AppTextTheme.whiteButton?.copyWith(color: Colors.black87)),
      ),
    );
  }
}
