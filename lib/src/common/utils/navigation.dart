import 'package:flutter/material.dart';

class AppNavigation {
  AppNavigation._();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(String routeName, {dynamic arguments}) async {
    return await navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  static pop(value) {
    return navigatorKey.currentState!.pop(value);
  }

  static goBack() {
    return navigatorKey.currentState!.pop();
  }

  static popUntil(String desiredRoute) {
    return navigatorKey.currentState!.popUntil((route) {
      return route.settings.name == desiredRoute;
    });
  }

  static pushNamedAndRemoveUntil(route, popToInitial) async {
    return await navigatorKey.currentState!.pushNamedAndRemoveUntil(
      route,
      (Route<dynamic> route) => popToInitial,
    );
  }

  static pushReplacementNamed(String desiredRoute, {dynamic arguments}) async {
    return await navigatorKey.currentState!.pushReplacementNamed(desiredRoute, arguments: arguments);
  }

  static popAndPushUntil(String route, {dynamic arguments}) async {
    return await navigatorKey.currentState!.popAndPushNamed(route, arguments: arguments);
  }

  static BuildContext getNavigationContext() {
    return navigatorKey.currentState!.context;
  }
}