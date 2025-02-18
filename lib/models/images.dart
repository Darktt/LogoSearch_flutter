import 'package:flutter/material.dart';

final class Images {
  static final TableImages table = TableImages._instance;
}

class TableImages {
  static final TableImages _instance = TableImages._();

  TableRowImages row = TableRowImages._();

  TableImages._();
}

final class TableRowImages {
  final Image detail = Image(image: AssetImage('assets/images/detail.png'));

  TableRowImages._();
}
