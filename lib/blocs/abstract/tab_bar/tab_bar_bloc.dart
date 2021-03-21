import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:genetic_algorithms/ui/components/bar_item.dart';
import 'package:meta/meta.dart';

part 'tab_bar_event.dart';
part 'tab_bar_state.dart';

abstract class TabBarBloc extends Bloc<TabBarEvent, TabBarState> {
  late List<TabItem> _tabs;
  late int _index;

  TabBarBloc(List<TabItem> tabs, int initialIndex)
      : super(TabBarInitialState()) {
    assert(
        tabs.length > initialIndex, 'initialIndex for navbar is out of range');
    _index = initialIndex;
    _tabs = tabs;
  }

  int get index => _index;
  List<TabItem> get tabs => _tabs;
  int get tabLenght => _tabs.length;
  TabItem get currentTab => _tabs.elementAt(_index);

  @override
  Stream<TabBarState> mapEventToState(
    TabBarEvent event,
  ) async* {
    if (event is TabBarChangeEvent) {
      yield* mapTabBarChangeEvent(event.index);
    }
  }

  Stream<TabBarState> mapTabBarChangeEvent(int newIndex) async* {
    yield TabBarChangeInProgressState();
    _index = newIndex;
    yield TabBarChangeSuccessState();
  }
}
