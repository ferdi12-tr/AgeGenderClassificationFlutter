import 'package:flutter/material.dart';
import 'package:thales/pages/home_page.dart';
import 'package:thales/pages/show_page.dart';

class RouteManager {
  static const String homePage = '/';
  static const String showPage = '/showPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var valuePassed;
    if (settings.arguments != null) {
      valuePassed = settings.arguments;
    }

    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case showPage:
        return MaterialPageRoute(
          builder: (context) => ShowPage(Ximage: valuePassed),
        );
      default:
        throw ('Sayfa Bulunamadı.');
    }
  }
}
