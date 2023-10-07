import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 250,
        child: Column(
          children: [
            Image(
              height: 200,
              width: 200,
              image: AssetImage('assets/logo.png'),
            ),
            Text('Chat App'),
          ],
        ),
      ),
    );
  }
}
