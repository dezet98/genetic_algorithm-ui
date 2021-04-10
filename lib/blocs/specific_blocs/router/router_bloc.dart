import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:genetic_algorithms/shared/exceptions.dart';
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
      yield* mapNavigateToEvent(event.destination, event.routeArgs);
    } else if (event is RouterBackEvent) {
      yield RouterBackState();
    }
  }

  Stream<RouterState> mapNavigateToEvent(
      RouteName routeName, RouteArgs? routeArgs) async* {
    try {
      yield RouterChangeRouteInProgressState();
      Widget screen = _fromRouteName(routeName, routeArgs);
      yield RouterChangeRouteSuccessState(
        MaterialPageRoute(builder: (_) => screen),
      );
    } catch (e) {
      if (e is RouterException) {
        yield RouterChangeRouteFailureState(e.routerError, message: e.message);
      } else {
        yield RouterChangeRouteFailureState(RouterError.UNDEFINED,
            message: e.toString());
      }
    }
  }

  Widget _fromRouteName(RouteName routeName, RouteArgs? routeArgs) {
    try {
      switch (routeName) {
        case RouteName.HOME_SCREEN:
          return HomeScreen();
        case RouteName.RESULTS_DETAILS:
          ResultDetailsScreenArgs args = routeArgs as ResultDetailsScreenArgs;
          return ResultDetailsScreen(args: args);
      }
    } catch (e) {
      throw RouterException(RouterError.ARGS_ERROR, e.toString());
    }
  }
}

abstract class RouteArgs {}
