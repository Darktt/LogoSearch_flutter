import 'package:flutter/material.dart';

final class TextStyles {
  // headlineLarge
  static final TextStyle headlineLarge = TextStyle(
    fontSize: 34.0,
    fontWeight: FontWeight.normal,
  );

  // title1
  static final TextStyle title1 = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.normal,
  );

  // title2
  static final TextStyle title2 = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.normal,
  );

  // title3
  static final TextStyle title3 = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.normal,
  );

  // headline
  static final TextStyle headline = TextStyle(
    fontSize: 17.0,
    fontWeight: FontWeight.w600,
  );

  // body
  static final TextStyle body = TextStyle(
    fontSize: 17.0,
    fontWeight: FontWeight.normal,
  );

  // callout
  static final TextStyle callout = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
  );

  // subhead
  static final TextStyle subhead = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.normal,
  );

  // footnote
  static final TextStyle footnote = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.normal,
  );

  // caption1
  static final TextStyle caption1 = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
  );

  // caption2
  static final TextStyle caption2 = TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.normal,
  );

  TextStyles._();
}

extension WithColor on TextStyle {
  // ignore: unused_element
  TextStyle withColor(Color color) {
    return copyWith(color: color);
  }

  // ignore: unused_element
  TextStyle withBackgroundColor(Color color) {
    return copyWith(backgroundColor: color);
  }
}
