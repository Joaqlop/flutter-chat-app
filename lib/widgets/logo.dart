import 'package:chat_app/config/theme/apptext_theme.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Image(
              height: 175,
              width: 175,
              image: AssetImage('assets/logo.png'),
            ),
            SizedBox(
              height: 50,
              child: Text('Chatting!', style: AppTextTheme.logoTitle),
            )
          ],
        ),
      ),
    );
  }
}
