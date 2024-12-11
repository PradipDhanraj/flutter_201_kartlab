import 'dart:async';
import 'package:bloc/bloc.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(index: 0)) {
    on<UpdateIndex>(_updateIndexFunc);
    on<AddRegistryEvent>(_addRegistryData);
  }

  FutureOr<void> _updateIndexFunc(UpdateIndex event, Emitter<HomeState> emit) {
    emit(state.copyWith(index: event.index));
  }

  FutureOr<void> _addRegistryData(AddRegistryEvent event, Emitter<HomeState> emit) {
    var list = [...state.registryList, event.data];
    print(list);
    emit(state.copyWith(registryList: list));
  }
}
