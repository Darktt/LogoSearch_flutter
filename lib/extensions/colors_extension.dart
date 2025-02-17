import 'package:flutter/material.dart';

final class CustomColors {
  // Default colors
  static const Color lightGray = Color(0xFF9A9A9A);

  // Background colors
  static const Color background = Color(0xFF0E0E1C);
  static const Color foreground = Colors.white;
  static const Color borderLine = Color(0xFF323232);

  // TextColor colors
  static final TextColor text = TextColor._();

  // ButtonColor colors
  static final ButtonColor button = ButtonColor._();
}

class ButtonColor {
  // ButtonColor colors
  final Color background = Colors.white;
  final Color foreground = Colors.black;

  ButtonColor._();
}

class TextColor {
  // TextColor colors
  final Color primary = Colors.white;
  final Color secondary = Color(0xFF9A9A9A);
  final Color hint = Color(0xFF9A9A9A);

  TextColor._();
}
