import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  const AppTextTheme._();

  static TextTheme get montserratTextTheme => GoogleFonts.montserratTextTheme();

  static TextStyle? get greyBody => montserratTextTheme.bodyMedium?.copyWith(
        color: Colors.grey.shade600,
        fontSize: 14,
      );

  static TextStyle? get whiteButton => montserratTextTheme.bodyMedium?.copyWith(
        color: Colors.grey.shade200,
        fontSize: 14,
      );
  static TextStyle? get blueBody => montserratTextTheme.bodyMedium?.copyWith(
        color: Colors.blueAccent,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      );
}
