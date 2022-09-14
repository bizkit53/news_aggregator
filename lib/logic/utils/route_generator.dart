import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:news_aggregator/constans/routes.dart';
import 'package:news_aggregator/logic/utils/logger.dart';
import 'package:news_aggregator/presentation/pages/splash_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Logger log = logger(RouteGenerator);
    log.i('generateRoute called with route: ${settings.name}');

    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(
          builder: ((context) => const SplashPage()),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return const Scaffold(
          body: Center(
            child: Text('Page not found!'),
          ),
        );
      },
    );
  }
}
