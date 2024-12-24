import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_201_kartlab/src/common/services/sharedPreferences/share_preferences_service.dart';
import 'package:flutter_201_kartlab/src/common/utils/constants.dart';
import 'package:flutter_201_kartlab/src/common/utils/locator.dart';
import 'package:flutter_201_kartlab/src/common/utils/navigation.dart';
import 'package:flutter_201_kartlab/src/modules/home/service/models/registry_model.dart';
import 'package:flutter_201_kartlab/src/modules/home/service/models/product_model.dart';
import 'package:flutter_201_kartlab/src/common/services/product_service/product_service.dart';
part 'gifts_event.dart';
part 'gifts_state.dart';

class GiftsBloc extends Bloc<GiftsEvent, GiftsState> {
  late SharePreferenceService sharedService;
  Function? refreshHomeRegistryList;
  GiftsBloc(this.refreshHomeRegistryList) : super(GiftsState()) {
    Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
    sharedService = locator.get<SharePreferenceService>();
    on<FetchCategories>(_fetctCatgories);
    on<FetchCategoryProducts>(_fetchCategoriesProducts);
    on<AddGiftToRegistry>(_addGiftToRegistry);
    on<OfflineEvent>(_offlineEvent);
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
    if (state.event == null) {
      var wishList = await sharedService.getData(Constants.wishlist);
      products.removeWhere((element) => !wishList.contains(element.productName));
    }
    var status = await Connectivity().checkConnectivity();
    if (status.last == ConnectivityResult.none) {
      products.clear();
    }
    emit(state.copyWith(
      products: products,
      categoryId: event.categoryId,
      event: state.event,
    ));
    refreshHomeRegistryList?.call();
  }

  FutureOr<void> _addGiftToRegistry(AddGiftToRegistry event, Emitter<GiftsState> emit) async {
    var list = (await sharedService.getData(Constants.registry)).map((e) => eventModelFromJson(e)).toList();
    var eventModel = list.firstWhere((element) => element.id == event.event.id);
    list.removeWhere((element) => element.id == event.event.id);
    await sharedService.prefs.remove(Constants.registry);
    if (eventModel.yourGift != null) {
      eventModel.gifts.removeWhere((element) => element.productName == eventModel.yourGift!.productName);
    }
    eventModel.gifts.add(event.gift);
    eventModel.yourGift = event.gift;
    list.add(eventModel);
    sharedService.setData(Constants.registry, list.map((e) => e.eventModelToJsonString()).toList());
    ScaffoldMessenger.of(AppNavigation.navigatorKey.currentContext!).showSnackBar(
      const SnackBar(content: Text('Item Added to registry')),
    );
    emit(state.copyWith(
      event: eventModel,
    ));
    refreshHomeRegistryList?.call();
    AppNavigation.goBack();
  }

  void _updateConnectionStatus(List<ConnectivityResult> event) {
    if (event.last == ConnectivityResult.none) {
      add(OfflineEvent());
      ScaffoldMessenger.of(AppNavigation.navigatorKey.currentContext!).showSnackBar(
        const SnackBar(content: Text('Please connect internet to load products')),
      );
    } else {
      add(FetchCategoryProducts("0", state.event));
    }
  }

  FutureOr<void> _offlineEvent(OfflineEvent event, Emitter<GiftsState> emit) {
    emit(state.copyWith(products: []));
  }
}
