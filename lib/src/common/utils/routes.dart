import 'package:flutter/material.dart';
import 'package:flutter_201_kartlab/src/modules/home/bloc/home_bloc.dart';
import 'package:flutter_201_kartlab/src/modules/home/view/create_registry.dart';
import 'package:flutter_201_kartlab/src/modules/home/view/home.dart';
import 'package:flutter_201_kartlab/src/modules/gifts/view/add_gifts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(settings: settings, builder: (context) => Home());
    case Home.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => BlocProvider(
          create: (context) => HomeBloc(),
          child: Home(),
        ),
      );
    case AddGiftsPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const AddGiftsPage(),
      );
    case CreateRegistry.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => CreateRegistry(),
      );
    default:
      return MaterialPageRoute(settings: settings, builder: (context) => Home());
  }
}
