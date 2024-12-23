part of 'home_bloc.dart';

sealed class HomeEvent {}

class AddRegistryEvent extends HomeEvent {
  final EventModel data;
  AddRegistryEvent(this.data);
}

class InitDataEvent extends HomeEvent {}

class DeleteRegistry extends HomeEvent {
  final EventModel eventModel;
  DeleteRegistry(this.eventModel);
}

class UpdateIndexEvent extends HomeEvent {
  final int index;
  UpdateIndexEvent(this.index);
}

class UpdateProducts extends HomeEvent {
  final String categoryId;
  UpdateProducts(this.categoryId);
}

class UpdateWishList extends HomeEvent {
  final Products product;
  UpdateWishList(this.product);
}
