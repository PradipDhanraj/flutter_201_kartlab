part of 'gifts_bloc.dart';

sealed class GiftsEvent {}

class FetchCategories extends GiftsEvent {
  final EventModel event;
  FetchCategories(this.event);
}

class AddGiftToRegistry extends GiftsEvent {
  final Products gift;
  final EventModel event;
  AddGiftToRegistry(this.gift, this.event);
}

class FetchCategoryProducts extends GiftsEvent {
  final String categoryId;
  final EventModel event;
  FetchCategoryProducts(this.categoryId, this.event);
}
