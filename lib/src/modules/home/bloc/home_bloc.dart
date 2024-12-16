import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_201_kartlab/src/common/services/sharedPreferences/share_preferences_service.dart';
import 'package:flutter_201_kartlab/src/common/utils/locator.dart';
import 'package:flutter_201_kartlab/src/common/utils/navigation.dart';
import 'package:flutter_201_kartlab/src/modules/home/service/models/registry_model.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(index: 0)) {
    on<AddRegistryEvent>(_addRegistryData);
    on<InitDataEvent>(_initDataFunction);
    on<DeleteRegistry>(_deleteRegistry);
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
    emit(state.copyWith(registryList: list));
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
}
