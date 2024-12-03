import 'package:flutter/material.dart';
import 'package:flutter_201_kartlab/src/modules/home/view/home.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(settings: settings, builder: (context) => const Home());
    case Home.routeName:
      return MaterialPageRoute(settings: settings, builder: (context) => const Home());
    default:
      return MaterialPageRoute(settings: settings, builder: (context) => const Home());
  }
}
