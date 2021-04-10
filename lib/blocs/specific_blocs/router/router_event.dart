part of 'router_bloc.dart';

@immutable
abstract class RouterEvent {}

class RouterNavigateToEvent implements RouterEvent {
  final RouteName destination;
  final RouteArgs? routeArgs;

  RouterNavigateToEvent(this.destination, {this.routeArgs});
}

class RouterBackEvent implements RouterEvent {}
