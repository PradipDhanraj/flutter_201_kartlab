// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_201_kartlab/src/common/utils/navigation.dart';
import 'package:flutter_201_kartlab/src/common/widgets/appbar.dart';
import 'package:flutter_201_kartlab/src/modules/common/bloc/common_bloc.dart';
import 'package:flutter_201_kartlab/src/modules/home/bloc/home_bloc.dart';
import 'package:flutter_201_kartlab/src/modules/home/service/models/registry_model.dart';
import 'package:flutter_201_kartlab/src/modules/home/view/create_registry.dart';
import 'package:flutter_201_kartlab/src/modules/gifts/view/add_gifts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  static const String routeName = 'home';
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar('KartLabs'),
      floatingActionButton: InkWell(
        splashColor: Colors.black,
        onTap: () {
          AppNavigation.navigateTo(CreateRegistry.routeName).then((value) {
            context.read<HomeBloc>().add(AddRegistryEvent(value));
          });
        },
        child: const Icon(
          Icons.add_circle_sharp,
          size: 40,
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: state.registryList
                    .map(
                      (e) => InkWell(
                          child: RegistryWidget(e),
                          onTap: () {
                            context.read<CommonBloc>().add(
                                  NavigationEvent(
                                    AddGiftsPage.routeName,
                                    args: e,
                                  ),
                                );
                          }),
                    )
                    .toList(),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.index,
            backgroundColor: Colors.black,
            selectedIconTheme: const IconThemeData(
              color: Colors.white,
              opacity: 1,
            ),
            unselectedIconTheme: const IconThemeData(
              color: Colors.white,
              opacity: .5,
            ),
            selectedItemColor: Colors.white,
            // selectedLabelStyle: const TextStyle(color: Colors.white),
            // unselectedLabelStyle: const TextStyle(color: Colors.white),
            showSelectedLabels: true,
            showUnselectedLabels: false,
            elevation: 10,
            type: BottomNavigationBarType.shifting,
            onTap: (value) {
              context.read<HomeBloc>().add(UpdateIndex(value));
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                backgroundColor: Colors.black87,
                icon: Icon(Icons.app_registration_sharp),
                label: 'Registry',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Add Item',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.share),
                label: 'Share List',
              ),
            ],
          );
        },
      ),
    );
  }
}

class RegistryWidget extends StatelessWidget {
  final EventModel data;
  const RegistryWidget(
    this.data, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Column(
        children: [
          Flexible(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: Text(
                  data.title,
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              color: Colors.red,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data.eventDate.difference(DateTime.now()).inDays.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Days left",
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "0",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Fulfilled",
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "20",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Total gifts",
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
