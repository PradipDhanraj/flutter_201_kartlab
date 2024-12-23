import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_201_kartlab/src/common/services/product_service/product_service.dart';
import 'package:flutter_201_kartlab/src/common/services/sharedPreferences/share_preferences_service.dart';
import 'package:flutter_201_kartlab/src/common/utils/locator.dart';
import 'package:flutter_201_kartlab/src/common/utils/navigation.dart';
import 'package:flutter_201_kartlab/src/modules/home/service/models/product_model.dart';
import 'package:flutter_201_kartlab/src/modules/home/service/models/registry_model.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(index: 0)) {
    on<AddRegistryEvent>(_addRegistryData);
    on<InitDataEvent>(_initDataFunction);
    on<DeleteRegistry>(_deleteRegistry);
    on<UpdateIndexEvent>(_updateIndex);
    on<UpdateProducts>(_updateproducts);
    on<UpdateWishList>(_updateWishlist);
  }

  FutureOr<void> _addRegistryData(AddRegistryEvent event, Emitter<HomeState> emit) {
    var list = [...state.registryList, event.data];
    locator.get<SharePreferenceService>().setData(
        "registry",
        list
            .map(
              (e) => e.eventModelToJsonString(),
            )
            .toList());
    emit(state.copyWith(registryList: list));
  }

  FutureOr<void> _initDataFunction(InitDataEvent event, Emitter<HomeState> emit) async {
    var dataList = await locator.get<SharePreferenceService>().getData('registry');
    var list = dataList.map((e) => eventModelFromJson(e)).toList();
    var categories = await locator.get<ProductService>().getCategories();
    emit(state.copyWith(registryList: list, categories: categories));
    if (state.products.isEmpty) {
      add(UpdateProducts(state.categoryid));
    }
  }

  FutureOr<void> _deleteRegistry(DeleteRegistry event, Emitter<HomeState> emit) async {
    var sharedService = locator.get<SharePreferenceService>();
    var list = (await sharedService.getData('registry')).map((e) => eventModelFromJson(e)).toList();
    //var eventModel = list.firstWhere((element) => element.id == event.eventModel.id);
    list.removeWhere((element) => element.id == event.eventModel.id);
    await sharedService.prefs.clear();
    sharedService.setData('registry', list.map((e) => e.eventModelToJsonString()).toList());
    ScaffoldMessenger.of(AppNavigation.navigatorKey.currentContext!).showSnackBar(
      const SnackBar(content: Text('Deleted registry')),
    );
    add(InitDataEvent());
  }

  FutureOr<void> _updateIndex(UpdateIndexEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(index: event.index));
  }

  FutureOr<void> _updateproducts(UpdateProducts event, Emitter<HomeState> emit) async {
    var products = await locator.get<ProductService>().getProductList();
    if (event.categoryId != "0") {
      products.removeWhere((element) => element.productCategoryId != event.categoryId);
    }
    emit(state.copyWith(products: products, categoryId: event.categoryId));
  }

  FutureOr<void> _updateWishlist(UpdateWishList event, Emitter<HomeState> emit) {
    // var product = state.products.firstWhere((element) => element.productName == event.product.productName);
    // product.isInMyWishList = !event.product.isInMyWishList;
    for (var element in state.products) {
      if (element.productName == event.product.productName) {
        element.isInMyWishList = !event.product.isInMyWishList;
      }
    }
    emit(state.copyWith(products: state.products));
  }
}
