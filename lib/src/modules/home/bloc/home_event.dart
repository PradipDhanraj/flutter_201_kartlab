part of 'home_bloc.dart';

sealed class HomeEvent {}

class UpdateIndex extends HomeEvent {
  final int index;
  UpdateIndex(this.index);
}
class AddRegistryEvent extends HomeEvent {
  final EventModel data;
  AddRegistryEvent(this.data);
}
