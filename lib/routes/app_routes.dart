import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../screens/home_screen.dart';
import '../screens/movie_detail_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String search = '/search';
  static const String detail = '/detail';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> get routes => {
        home: (_) => const HomeScreen(),
        search: (_) => const SearchScreen(),
        profile: (_) => const ProfileScreen(),
      };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == detail) {
      final args = settings.arguments;
      if (args is Movie) {
        return MaterialPageRoute(
          builder: (_) => MovieDetailScreen(movie: args),
        );
      }
      if (args is Map<String, String>) {
        return MaterialPageRoute(
          builder: (_) => MovieDetailScreen.fromMap(args),
        );
      }
    }
    return null;
  }
}
