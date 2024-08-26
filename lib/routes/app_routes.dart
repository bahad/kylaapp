import 'package:flutter/material.dart';
import 'package:kyla/features/home_screen.dart';

class AppRoutes {
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      /*    case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case detail:
        final args = settings.arguments as Model;
        return MaterialPageRoute(
          builder: (_) => DetailScreen(
            model: args,
          ),
        ); */
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
