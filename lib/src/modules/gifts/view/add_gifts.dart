import 'package:flutter/material.dart';
import 'package:flutter_201_kartlab/src/common/utils/navigation.dart';
import 'package:flutter_201_kartlab/src/common/widgets/product_card.dart';
import 'package:flutter_201_kartlab/src/modules/gifts/bloc/gifts_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddGiftsPage extends StatelessWidget {
  static const String routeName = "registry_details";
  const AddGiftsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocConsumer<GiftsBloc, GiftsState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Text(
                state.event != null ? "Gift Categories" : "Wish List",
                style: const TextStyle(
                  fontSize: null,
                ),
              );
            }),
        leading: InkWell(
          onTap: () {
            try {
              ((ModalRoute.of(context)!.settings.arguments as List).first as Function?)?.call();
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
                                  state.event,
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
                if (state.products.isEmpty)
                  const SizedBox(
                    height: 200,
                    child: Center(
                      child: Text("Add products in your wishlist from home page."),
                    ),
                  ),
                if (state.products.isNotEmpty)
                  ...state.products.map(
                    (e) => InkWell(
                      onTap: state.event != null
                          ? () {
                              context.read<GiftsBloc>().add(AddGiftToRegistry(e, state.event!));
                            }
                          : null,
                      child: ProductCardWidget(
                        e,
                        isSelected: e.productName == state.event?.yourGift?.productName,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
