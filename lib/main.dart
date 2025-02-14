import 'package:flutter/material.dart';
import 'package:logo_search/models/api_key.dart';
import 'package:provider/provider.dart';
import 'package:logo_search/search_logo_page.dart';
import 'package:logo_search/view_model/logo_search_store.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Properties

  final LogoSearchStore _store = kLogoSearchStore;

  MyApp({super.key}) {
    if (APIKey.publicKey == 'your_public_key') {
      throw Exception('Please set your public key in lib/models/api_key.dart');
    }

    if (APIKey.secretKey == 'your_secret_key') {
      throw Exception('Please set your secret key in lib/models/api_key.dart');
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SearchLogoPage(),
      ),
    );
  }
}
