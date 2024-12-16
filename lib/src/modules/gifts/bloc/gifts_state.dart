part of 'gifts_bloc.dart';

class GiftsState {
  final List<Categories> categories;
  final List<Products> products;
  final String categoryId;
  final EventModel? event;
  GiftsState({this.products = const [], this.categories = const [], this.categoryId = "0", this.event});
  GiftsState copyWith({
    List<Categories>? categories,
    List<Products>? products,
    String? categoryId,
    EventModel? event,
  }) {
    return GiftsState(
      categories: categories ?? this.categories,
      products: products ?? this.products,
      categoryId: categoryId ?? this.categoryId,
      event: event ?? this.event,
    );
  }
}
