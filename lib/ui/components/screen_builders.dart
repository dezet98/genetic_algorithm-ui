import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/tab_bar/tab_bar_bloc.dart';
import 'package:genetic_algorithms/shared/theme.dart';

class ScreenWithBar {
  static Widget bottom(
    BuildContext context,
    TabBarBloc tabBarBloc, {
    double padding = Directions.screenPadding,
  }) {
    return BlocBuilder(
      bloc: tabBarBloc,
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.all(padding),
            child: tabBarBloc.currentTab,
          )),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabBarBloc.index,
            items:
                tabBarBloc.tabs.map((e) => e.bottomBarItem(context)).toList(),
            onTap: (int index) {
              tabBarBloc.add(TabBarChangeEvent(index));
            },
          ),
        );
      },
    );
  }
}
