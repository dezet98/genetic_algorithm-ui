part of 'router_bloc.dart';

@immutable
abstract class RouterState {
  MaterialPageRoute get route;
}

class RouterInitialState extends RouterState {
  final MaterialPageRoute<dynamic> route;

  RouterInitialState(this.route);
}

class RouterChangeRouteState extends RouterState {
  final MaterialPageRoute<dynamic> route;

  RouterChangeRouteState(this.route);
}
