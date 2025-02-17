import 'package:flutter/material.dart';
import 'package:logo_search/search_logo_page.dart';

final class Route {
  final String name;
  final WidgetBuilder builder;

  const Route._({required this.name, required this.builder});
}

final class Routes {
  static final Route initialRoute = Route._(
    name: '/',
    builder: (context) => SearchLogoPage(),
  );

  static final List<Route> _routes = [
    initialRoute,
  ];

  static Map<String, WidgetBuilder> get routes {
    return _routes.fold<Map<String, WidgetBuilder>>(
      {},
      (map, route) => map..addAll({route.name: route.builder}),
    );
  }
}
