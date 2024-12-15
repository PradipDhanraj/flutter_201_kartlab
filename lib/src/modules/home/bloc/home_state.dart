part of 'home_bloc.dart';

class HomeState {
  final int index;
  final List<EventModel> registryList;
  HomeState({
    required this.index,
    this.registryList = const [],
  });

  HomeState copyWith({
    int? index,
    List<EventModel>? registryList,
  }) {
    return HomeState(
      index: index ?? this.index,
      registryList: registryList ?? this.registryList,
    );
  }
}
