part of 'router_bloc.dart';

@immutable
abstract class RouterState {}

class RouterInitialState extends RouterState {
  final MaterialPageRoute<dynamic> route;

  RouterInitialState(this.route);
}

class RouterChangeRouteInProgressState extends RouterState {}

class RouterChangeRouteSuccessState extends RouterState {
  final MaterialPageRoute<dynamic> route;

  RouterChangeRouteSuccessState(this.route);
}

class RouterChangeRouteFailureState extends RouterState {
  final RouterError routerError;
  final String? message;

  RouterChangeRouteFailureState(this.routerError, {this.message});
}

class RouterBackState extends RouterState {}
