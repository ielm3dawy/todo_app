import 'package:flutter/material.dart';
import 'package:todo_app_c11/core/page_route_names.dart';
import 'package:todo_app_c11/moduls/layout_view.dart';
import 'package:todo_app_c11/moduls/login/login_view.dart';
import 'package:todo_app_c11/moduls/registration/registration_view.dart';
import 'package:todo_app_c11/moduls/splash/splash_view.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRouteName.initial:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
          settings: settings,
        );
      case PageRouteName.login:
        return MaterialPageRoute(
            builder: (context) => const LoginView(), settings: settings);
      case PageRouteName.registration:
        return MaterialPageRoute(
            builder: (context) => const RegistrationView(), settings: settings);
      case PageRouteName.layout:
        return MaterialPageRoute(
            builder: (context) => const LayoutView(), settings: settings);
      default:
        return MaterialPageRoute(builder: (context) => const SplashView());
    }
  }
}
