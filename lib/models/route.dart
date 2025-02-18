import 'package:flutter/material.dart';
import 'package:logo_search/logo_detail_page/logo_detail_page.dart';
import 'package:logo_search/search_logo_page/search_logo_page.dart';

abstract class Route {
  final String name;
  final WidgetBuilder builder;

  const Route._({required this.name, required this.builder});
}

final class HomeRoute extends Route {
  static final HomeRoute _instance = HomeRoute._();

  HomeRoute._() : super._(name: '/', builder: (context) => SearchLogoPage());
}

final class DetailRoute extends Route {
  static final DetailRoute instance = DetailRoute._();

  DetailRoute._()
      : super._(name: '/detail', builder: (context) => LogoDetailPage());
}

final class Routes {
  static final Route initialRoute = HomeRoute._instance;

  static final List<Route> _routes = [
    initialRoute,
    DetailRoute.instance,
  ];

  static Map<String, WidgetBuilder> get routes {
    return _routes.fold<Map<String, WidgetBuilder>>(
      {},
      (map, route) => map..addAll({route.name: route.builder}),
    );
  }

  static void next(Route route, BuildContext context, dynamic arguments) {
    Navigator.pushNamed(context, route.name, arguments: arguments);
  }
}
