import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_201_kartlab/src/common/utils/constants.dart';
import 'package:flutter_201_kartlab/src/common/utils/navigation.dart';
import 'package:flutter_201_kartlab/src/common/widgets/product_card.dart';
import 'package:flutter_201_kartlab/src/modules/common/bloc/common_bloc.dart';
import 'package:flutter_201_kartlab/src/modules/home/bloc/home_bloc.dart';
import 'package:flutter_201_kartlab/src/modules/home/service/models/registry_model.dart';
import 'package:flutter_201_kartlab/src/modules/home/view/create_registry.dart';
import 'package:flutter_201_kartlab/src/modules/gifts/view/add_gifts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatelessWidget {
  static const String routeName = 'home';
  const Home({super.key});

  Widget _pages(HomeState state, BuildContext context) {
    switch (state.index) {
      case 1:
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: state.registryList.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!.createNewRegistry,
                    textAlign: TextAlign.center,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: state.registryList.map((e) => RegistryWidget(e)).toList(),
                  ),
                ),
        );
      default:
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Wrap(
              spacing: 10,
              children: state.categories.map((e) {
                return InkWell(
                  onTap: () {
                    context.read<HomeBloc>().add(UpdateProducts(e.categoryId));
                  },
                  child: Chip(
                    backgroundColor: null,
                    label: Text(
                      e.categoryTitle,
                      style: const TextStyle(color: null),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          ...state.products.map(
            (e) => ProductCardWidget(
              e,
              showWishIcon: true,
              addToWishlistFunc: () {
                context.read<HomeBloc>().add(UpdateWishList(e));
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.kartlabs,
            style: const TextStyle(
              fontSize: null,
            ),
          ),
          leading: InkWell(
            onTap: () {
              context.read<CommonBloc>().add(NavigationEvent(AddGiftsPage.routeName, args: [
                    null,
                    null,
                  ]));
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
              child: Chip(
                label: Text(AppLocalizations.of(context)!.newEvent),
                avatar: const Icon(Icons.add),
              ),
            ),
          ]),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return _pages(state, context);
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
            onTap: (value) => context.read<HomeBloc>().add(UpdateIndexEvent(value)),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: AppLocalizations.of(context)!.home,
              ),
              const BottomNavigationBarItem(
                backgroundColor: Colors.black87,
                icon: Icon(Icons.list),
                label: Constants.registry,
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
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            data.title,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 20),
                          ),
                          if (data.desc.isNotEmpty)
                            Text(
                              data.desc,
                              style: const TextStyle(fontSize: 15),
                            ),
                        ],
                      ),
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
                            label: Text(data.yourGift == null
                                ? AppLocalizations.of(context)!.chooseGift
                                : AppLocalizations.of(context)!.viewYourGift),
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
                      Text(
                        AppLocalizations.of(context)!.daysLeft,
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
                      Text(
                        AppLocalizations.of(context)!.totalGifts,
                      ),
                    ],
                  ),
                  if (data.yourGift != null)
                    InkWell(
                      onTap: () async {
                        final box = context.findRenderObject() as RenderBox?;
                        await Share.share(
                          jsonEncode(data.toJson()),
                          subject: AppLocalizations.of(context)!.shareGifts,
                          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.share,
                            size: 30,
                          ),
                          Text(
                            AppLocalizations.of(context)!.share,
                          ),
                        ],
                      ),
                    ),
                  InkWell(
                      onTap: () {
                        context.read<HomeBloc>().add(DeleteRegistry(data));
                      },
                      child: Chip(
                        label: Text(AppLocalizations.of(context)!.delete),
                        avatar: const Icon(
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
