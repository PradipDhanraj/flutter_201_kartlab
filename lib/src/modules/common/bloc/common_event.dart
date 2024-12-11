part of 'common_bloc.dart';

sealed class CommonEvent {}

class NavigationEvent extends CommonEvent {
  final String routeName;
  final dynamic args;
  NavigationEvent(this.routeName, {this.args});
}
