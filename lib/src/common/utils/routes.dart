import 'package:flutter/material.dart';
import 'package:flutter_201_kartlab/src/modules/gifts/bloc/gifts_bloc.dart';
import 'package:flutter_201_kartlab/src/modules/home/bloc/home_bloc.dart';
import 'package:flutter_201_kartlab/src/modules/home/service/models/registry_model.dart';
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
          create: (context) => HomeBloc()..add(InitDataEvent()),
          child: Home(),
        ),
      );
    case AddGiftsPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => BlocProvider(
          create: (context) => GiftsBloc((settings.arguments as List).first as Function)
            ..add(
              FetchCategories((settings.arguments as List).last as EventModel),
            ),
          child: const AddGiftsPage(),
        ),
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
