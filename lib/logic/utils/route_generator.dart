import 'package:flutter/material.dart';
import 'package:news_aggregator/constans/routes.dart';
import 'package:news_aggregator/logic/utils/bloc_injector.dart';
import 'package:news_aggregator/logic/utils/logger.dart';
import 'package:news_aggregator/presentation/pages/login_page.dart';
import 'package:news_aggregator/presentation/pages/welcome_page.dart';

/// In-app navigation handler
class RouteGenerator {
  /// Incoming root handler to change the page
  static Route<dynamic> generateRoute(RouteSettings settings) {
    logger(RouteGenerator).i(
      'generateRoute called with route: ${settings.name}',
    );

    switch (settings.name) {
      case welcomeRoute:
        return MaterialPageRoute(
          builder: (context) => BlocInjector(
            child: const WelcomePage(),
          ),
        );
      case loginRoute:
        return MaterialPageRoute(
          builder: (context) => BlocInjector(
            child: const LoginPage(),
          ),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return BlocInjector(
          child: const Scaffold(
            body: Center(
              child: Text('Page not found!'),
            ),
          ),
        );
      },
    );
  }
}
