import 'package:flutter/material.dart';
import 'package:movies/shared/styles/app_colors.dart';
import 'package:movies/shared/styles/text_styles.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: AppColor.primary,
      primaryColor: AppColor.primary,
      brightness: Brightness.light,
      textTheme: TextTheme(
        bodyLarge: quick20White(),
        bodyMedium: poppins15White(),
        bodySmall: roboto8gray(),
      ),
      appBarTheme: const AppBarTheme(
          // backgroundColor: AppColor.lightColor,
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.white, size: 30)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(

        backgroundColor: AppColor.primary,
        elevation: 0,
        selectedItemColor: AppColor.secondary,
        unselectedItemColor: AppColor.grey,
      ));
}
