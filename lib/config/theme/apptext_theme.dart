import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  const AppTextTheme._();

  static TextTheme get interTextTheme => GoogleFonts.interTextTheme();
  static TextTheme get borelTextTheme => GoogleFonts.borelTextTheme();

  static TextStyle? get greyBody => interTextTheme.bodyMedium?.copyWith(
        color: Colors.grey.shade600,
        fontSize: 14,
      );

  static TextStyle? get greyTitle => interTextTheme.titleLarge?.copyWith(
        color: Colors.grey.shade600,
        fontSize: 18,
      );

  static TextStyle? get lightGreyBody => interTextTheme.bodyMedium?.copyWith(
        color: Colors.grey.shade400,
        fontSize: 14,
      );

  static TextStyle? get blackBody => interTextTheme.bodyMedium?.copyWith(
        color: Colors.black,
        fontSize: 14,
      );

  static TextStyle? get whiteButton => interTextTheme.bodyMedium?.copyWith(
        color: Colors.grey.shade100,
        fontSize: 14,
      );

  static TextStyle? get blueBody => interTextTheme.bodyMedium?.copyWith(
        color: const Color(0xff145a92),
        fontSize: 14,
      );

  static TextStyle? get logoTitle => borelTextTheme.titleLarge?.copyWith(
        color: const Color(0xff145a92),
        fontSize: 35,
        fontWeight: FontWeight.w600,
      );
}
