import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:genetic_algorithms/shared/routes.dart';
import 'package:genetic_algorithms/ui/screens/home/home_screen.dart';
import 'package:genetic_algorithms/ui/screens/result_details/result_details_screen.dart';
import 'package:meta/meta.dart';

part 'router_event.dart';
part 'router_state.dart';

class RouterBloc extends Bloc<RouterEvent, RouterState> {
  RouterBloc()
      : super(RouterInitialState(
            MaterialPageRoute(builder: (_) => CircularProgressIndicator())));

  @override
  Stream<RouterState> mapEventToState(
    RouterEvent event,
  ) async* {
    if (event is RouterNavigateToEvent) {
      yield* mapNavigateToEvent(event.destination, event.args);
    } else if (event is RouterBackEvent) {
      yield RouterBackState();
    }
  }

  Stream<RouterState> mapNavigateToEvent(
      RouteName routeName, Map<String, Object?>? args) async* {
    yield RouterChangeRouteState(
      MaterialPageRoute(builder: (_) => _fromRouteName(routeName, args)),
    );
  }

  Widget _fromRouteName(RouteName routeName, Map<String, Object?>? args) {
    switch (routeName) {
      case RouteName.HOME_SCREEN:
        return HomeScreen();
      case RouteName.RESULTS_DETAILS:
        return ResultDetailsScreen();
    }
  }
}
