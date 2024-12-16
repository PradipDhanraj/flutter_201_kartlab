import 'package:flutter/material.dart';
import 'package:flutter_201_kartlab/src/common/utils/navigation.dart';
import 'package:flutter_201_kartlab/src/modules/gifts/bloc/gifts_bloc.dart';
import 'package:flutter_201_kartlab/src/modules/home/service/models/product_model.dart';
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
            try {
              ((ModalRoute.of(context)!.settings.arguments as List).first as Function).call();
            } catch (_) {
            } finally {
              AppNavigation.goBack();
            }
          },
          child: const Icon(Icons.arrow_back_ios_new),
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
                ...state.products.map(
                  (e) => InkWell(
                    child: _productCard(e, e.productName == state.event?.yourGift?.productName),
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

  Widget _productCard(Products e, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          // border: Border.all(
          //   color: Colors.red,
          //   width: 2.0,
          // ),
          color: isSelected ? Colors.green : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.productName,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    e.productPrice,
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    e.productDescription,
                    softWrap: true,
                    maxLines: 4,
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
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
