import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_201_kartlab/src/common/utils/navigation.dart';
part 'common_event.dart';
part 'common_state.dart';

class CommonBloc extends Bloc<CommonEvent, CommonState> {
  List giftsList = <dynamic>[];
  CommonBloc() : super(CommonInitial()) {
    on<NavigationEvent>(_navigationFunc);
  }

  FutureOr<void> _navigationFunc(NavigationEvent event, Emitter<CommonState> emit) {
    AppNavigation.navigateTo(event.routeName, arguments: event.args);
  }
}
