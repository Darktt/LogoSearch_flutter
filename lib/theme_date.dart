import 'package:flutter/material.dart';
import 'package:logo_search/colors_extension.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: CustomColors.background,
    scaffoldBackgroundColor: CustomColors.background,
    appBarTheme: AppBarTheme(
      backgroundColor: CustomColors.background,
      titleTextStyle: TextStyle(color: Colors.white),
      centerTitle: true,
    ));
