import 'package:flutter/material.dart';
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
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "KartLabs",
            style: TextStyle(
              fontSize: null,
            ),
          ),
          leading: InkWell(
            onTap: () {
              // context.read<CommonBloc>().add(NavigationEvent(AddGiftsPage.routeName, args: [
              //       null,
              //       null,
              //     ]));
            },
            child: const Icon(Icons.bookmark),
          ),
          actions: [
            InkWell(
              onTap: () {
                AppNavigation.navigateTo(CreateRegistry.routeName).then((value) {
                  if (value != null) {
                    context.read<HomeBloc>().add(AddRegistryEvent(value));
                  }
                });
              },
              child: const Chip(
                label: Text('New Event'),
                avatar: Icon(Icons.add),
              ),
            ),
          ]),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: state.registryList.map((e) => RegistryWidget(e)).toList(),
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
              switch (value) {
                case 0:
                  AppNavigation.popUntil(Home.routeName);
                  break;
                case 1:
                  context.read<CommonBloc>().add(NavigationEvent(AddGiftsPage.routeName));
                  break;
                default:
              }
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                backgroundColor: Colors.black87,
                icon: Icon(Icons.app_registration_sharp),
                label: 'Registry',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Registry List',
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
              decoration: BoxDecoration(
                color: data.yourGift == null ? Colors.white10 : Colors.green.shade700,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          data.title,
                          style: const TextStyle(fontSize: 30),
                        ),
                        if (data.desc.isNotEmpty)
                          Text(
                            data.desc,
                            style: const TextStyle(fontSize: 15),
                          ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            context.read<CommonBloc>().add(
                                  NavigationEvent(
                                    AddGiftsPage.routeName,
                                    args: [
                                      () {
                                        context.read<HomeBloc>().add(InitDataEvent());
                                      },
                                      data,
                                    ],
                                  ),
                                );
                          },
                          child: Chip(
                            label: Text(data.yourGift == null ? 'Choose gift' : "View your gift"),
                            avatar: const Icon(Icons.card_giftcard),
                          ),
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     context.read<HomeBloc>().add(DeleteRegistry(data));
                        //   },
                        //   child: Icon(Icons.delete),
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: data.yourGift == null ? Colors.grey : Colors.green.shade900,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
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
                        style: const TextStyle(fontSize: 20),
                      ),
                      const Text(
                        "Days left",
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${data.gifts.length}",
                        style: const TextStyle(fontSize: 20),
                      ),
                      const Text(
                        "Total gifts",
                      ),
                    ],
                  ),
                  InkWell(
                      onTap: () {
                        context.read<HomeBloc>().add(DeleteRegistry(data));
                      },
                      child: const Chip(
                        label: Text("Delete"),
                        avatar: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      )),
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
