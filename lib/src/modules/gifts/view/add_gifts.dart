import 'package:flutter/material.dart';
import 'package:flutter_201_kartlab/src/common/utils/navigation.dart';
import 'package:flutter_201_kartlab/src/modules/gifts/bloc/gifts_bloc.dart';
import 'package:flutter_201_kartlab/src/modules/home/bloc/home_bloc.dart';
import 'package:flutter_201_kartlab/src/modules/products/service/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddGiftsPage extends StatelessWidget {
  static const String routeName = "registry_details";
  const AddGiftsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Gift Categories",
          style: TextStyle(
            fontSize: null,
          ),
        ),
        leading: InkWell(
          onTap: () {
            ((ModalRoute.of(context)!.settings.arguments as List).first as Function).call();
            AppNavigation.goBack();
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: BlocConsumer<GiftsBloc, GiftsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Wrap(
                    spacing: 10,
                    children: state.categories.map((e) {
                      var isSelected = state.categoryId == e.categoryId;
                      return InkWell(
                        onTap: () {
                          context.read<GiftsBloc>().add(
                                FetchCategoryProducts(
                                  e.categoryId,
                                  state.event!,
                                ),
                              );
                        },
                        child: Chip(
                          backgroundColor: isSelected ? Colors.white : null,
                          label: Text(
                            e.categoryTitle,
                            style: TextStyle(color: isSelected ? Colors.black : null),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                ...state.products.where((e) => !(state.event!.gifts).any((ee) => ee.productName == e.productName)).map(
                      (e) => InkWell(
                        child: _productCard(e),
                        onTap: () {
                          context.read<GiftsBloc>().add(AddGiftToRegistry(e, state.event!));
                        },
                      ),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _productCard(Products e) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          // border: Border.all(
          //   color: Colors.red,
          //   width: 2.0,
          // ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 1,
              child: Text(e.productName),
            ),
            Flexible(
              flex: 1,
              child: Image.network(e.productThumnailUrl),
            ),
          ],
        ),
      ),
    );
  }
}
