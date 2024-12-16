import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_201_kartlab/src/common/services/sharedPreferences/share_preferences_service.dart';
import 'package:flutter_201_kartlab/src/common/utils/locator.dart';
import 'package:flutter_201_kartlab/src/common/utils/navigation.dart';
import 'package:flutter_201_kartlab/src/modules/home/service/models/registry_model.dart';
import 'package:flutter_201_kartlab/src/modules/products/service/model/product_model.dart';
import 'package:flutter_201_kartlab/src/modules/products/service/product_service.dart';
part 'gifts_event.dart';
part 'gifts_state.dart';

class GiftsBloc extends Bloc<GiftsEvent, GiftsState> {
  late SharePreferenceService sharedService;
  Function? refreshHomeRegistryList;
  GiftsBloc(this.refreshHomeRegistryList) : super(GiftsState()) {
    sharedService = locator.get<SharePreferenceService>();
    on<FetchCategories>(_fetctCatgories);
    on<FetchCategoryProducts>(_fetchCategoriesProducts);
    on<AddGiftToRegistry>(_addGiftToRegistry);
  }

  FutureOr<void> _fetctCatgories(FetchCategories event, Emitter<GiftsState> emit) async {
    var categories = await locator.get<ProductService>().getCategories();
    emit(state.copyWith(
      categories: categories,
      event: event.event,
    ));
    add(FetchCategoryProducts("0", event.event));
  }

  FutureOr<void> _fetchCategoriesProducts(FetchCategoryProducts event, Emitter<GiftsState> emit) async {
    var products = await locator.get<ProductService>().getProductList();
    if (event.categoryId != "0") {
      products.removeWhere((element) => element.productCategoryId != event.categoryId);
    }
    if (event.event.gifts.isNotEmpty) {
      products.removeWhere((element) => event.event.gifts.any(
            (e) => element.productName == e.productName,
          ));
    }
    emit(state.copyWith(
      products: products,
      categoryId: event.categoryId,
      event: state.event,
    ));
    refreshHomeRegistryList?.call();
  }

  FutureOr<void> _addGiftToRegistry(AddGiftToRegistry event, Emitter<GiftsState> emit) async {
    var list = (await sharedService.getData('registry')).map((e) => eventModelFromJson(e)).toList();
    var eventModel = list.firstWhere((element) => element.id == event.event.id);
    list.removeWhere((element) => element.id == event.event.id);
    await sharedService.prefs.clear();
    if (!eventModel.gifts.any((element) => element.productName == event.gift.productName)) {
      eventModel.gifts.add(event.gift);
    }
    list.add(eventModel);
    sharedService.setData('registry', list.map((e) => e.eventModelToJsonString()).toList());
    ScaffoldMessenger.of(AppNavigation.navigatorKey.currentContext!).showSnackBar(
      const SnackBar(content: Text('Item Added to registry')),
    );
    emit(state.copyWith(
      event: eventModel,
    ));
  }
}
