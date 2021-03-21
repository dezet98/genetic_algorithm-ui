part of 'router_bloc.dart';

@immutable
abstract class RouterEvent {}

class RouterNavigateToEvent implements RouterEvent {
  final String destination;

  RouterNavigateToEvent(this.destination);
}

class RouterBack implements RouterEvent {}
