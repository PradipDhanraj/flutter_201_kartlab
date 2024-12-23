part of 'home_bloc.dart';

class HomeState {
  final int index;
  final List<EventModel> registryList;
  final List<Products> products;
  final List<Categories> categories;
  final String categoryid;
  HomeState({
    required this.index,
    this.registryList = const [],
    this.products = const [],
    this.categories = const [],
    this.categoryid = "0",
  });

  HomeState copyWith({
    int? index,
    List<EventModel>? registryList,
    List<Products>? products,
    List<Categories>? categories,
    String? categoryId,
  }) {
    return HomeState(
      index: index ?? this.index,
      registryList: registryList ?? this.registryList,
      products: products ?? this.products,
      categories: categories ?? this.categories,
      categoryid: categoryid,
    );
  }
}
