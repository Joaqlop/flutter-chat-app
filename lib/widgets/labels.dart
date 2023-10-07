import 'package:chat_app/config/theme/apptext_theme.dart';
import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels(
      {super.key,
      required this.account,
      required this.action,
      required this.onTap});

  final String account;
  final String action;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(account, style: AppTextTheme.greyBody),
          GestureDetector(
            onTap: onTap,
            child: Text(
              action,
              style: AppTextTheme.blueBody,
            ),
          )
        ],
      ),
    );
  }
}
