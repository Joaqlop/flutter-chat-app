import 'package:flutter/material.dart';

showAlert(BuildContext context, String title, String subtitle) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(subtitle),
      actions: [
        MaterialButton(
          elevation: 5,
          textColor: Colors.blueAccent,
          onPressed: () => Navigator.pop(context),
          child: const Center(child: Text('Reintentar')),
        ),
      ],
    ),
  );
}
