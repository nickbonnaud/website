import 'package:flutter/material.dart';
import 'package:website/routing/route_data.dart';
import 'package:website/routing/routes.dart';
import 'package:website/screens/home_screen.dart';

class AppRouter {

  const AppRouter();

  Route goTo({required BuildContext context, required RouteSettings settings}) {
    final RouteData routeData = RouteData.init(settings: settings);

    Route route;

    switch (routeData.route) {
      case Routes.app:
        route = _createRouteDefault(screen: const HomeScreen(), name: routeData.route);
        break;
      default:
        route = _createRouteDefault(screen: const HomeScreen(), name: '/');
    }

    return route;
  }

  MaterialPageRoute _createRouteDefault({required Widget screen, required String name}) {
    return MaterialPageRoute(
      builder: (_) => screen,
      settings: RouteSettings(name: name)
    );
  }
}