import 'package:flutter/material.dart';

extension CustomColors on Colors {
  // Default colors
  static const Color lightGray = Color(0xFF9A9A9A);

  // Background colors
  static const Color background = Color(0xFF0E0E1C);
  static const Color borderLine = Color(0xFF323232);

  // Text colors
  static const Color textPrimary = Colors.white;
  static const Color hintText = CustomColors.lightGray;

  // Button colors
  static final Button button = Button._getInstance();
}

class Button {
  static final Button _instance = Button._();

  // Button colors
  final Color background = Colors.white;
  final Color foreground = Colors.black;

  Button._();

  static Button _getInstance() => _instance;
}
