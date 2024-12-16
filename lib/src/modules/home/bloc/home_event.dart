part of 'home_bloc.dart';

sealed class HomeEvent {}

class AddRegistryEvent extends HomeEvent {
  final EventModel data;
  AddRegistryEvent(this.data);
}

class InitDataEvent extends HomeEvent {}
