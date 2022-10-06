import 'package:flutter/material.dart';
import 'package:news_aggregator/constans/routes.dart';
import 'package:news_aggregator/logic/utils/bloc_injector.dart';
import 'package:news_aggregator/logic/utils/logger.dart';
import 'package:news_aggregator/presentation/pages/forgot_password_page.dart';
import 'package:news_aggregator/presentation/pages/login_page.dart';
import 'package:news_aggregator/presentation/pages/register_page.dart';
import 'package:news_aggregator/presentation/pages/verification_page.dart';
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
        return _pageWithBloc(child: const WelcomePage());
      case registerRoute:
        return _pageWithBloc(child: const RegisterPage());
      case loginRoute:
        return _pageWithBloc(child: const LoginPage());
      case forgotPasswordRoute:
        return _pageWithBloc(child: const ForgotPasswordPage());
      case verificationRoute:
        return _pageWithBloc(child: const VerificationPage());

      default:
        return _errorRoute();
    }
  }

  static MaterialPageRoute<dynamic> _pageWithBloc({required Widget child}) {
    return MaterialPageRoute(
      builder: (context) => BlocInjector(
        child: child,
      ),
    );
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
