part of 'home_bloc.dart';

class HomeState {
  final int index;
  final List<dynamic> registryList;
  HomeState({
    required this.index,
    this.registryList = const [],
  });

  HomeState copyWith({
    int? index,
    List<dynamic>? registryList,
  }) {
    return HomeState(
      index: index ?? this.index,
      registryList: registryList ?? this.registryList,
    );
  }
}
