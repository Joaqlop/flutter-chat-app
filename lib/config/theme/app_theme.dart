import 'package:chat_app/config/theme/theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey.shade100,
        colorSchemeSeed: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade100,
          elevation: 0,
        ),
        listTileTheme: ListTileThemeData(
          titleTextStyle: AppTextTheme.greyBody,
          subtitleTextStyle: AppTextTheme.greyBody?.copyWith(fontSize: 13),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
          hintStyle: AppTextTheme.lightGreyBody,
        ),
      );
}
