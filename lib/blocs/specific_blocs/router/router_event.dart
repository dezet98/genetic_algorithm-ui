part of 'router_bloc.dart';

@immutable
abstract class RouterEvent {}

class RouterNavigateToEvent implements RouterEvent {
  final RouteName destination;
  final Map<String, Object?>? args;

  RouterNavigateToEvent(this.destination, {this.args});
}

class RouterBackEvent implements RouterEvent {}
