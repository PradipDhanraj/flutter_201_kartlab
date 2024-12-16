import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_201_kartlab/src/common/services/sharedPreferences/share_preferences_service.dart';
import 'package:flutter_201_kartlab/src/common/utils/locator.dart';
import 'package:flutter_201_kartlab/src/modules/home/service/models/registry_model.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(index: 0)) {
    on<AddRegistryEvent>(_addRegistryData);
    on<InitDataEvent>(_initDataFunction);
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
}
