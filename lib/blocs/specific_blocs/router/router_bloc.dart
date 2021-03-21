import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
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
      yield* mapNavigateToEvent();
    }
  }

  Stream<RouterState> mapNavigateToEvent() async* {
    yield RouterChangeRouteState(
      MaterialPageRoute(builder: (_) => CircularProgressIndicator()),
    );
  }
}
