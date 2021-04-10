import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/tab_bar/tab_bar_bloc.dart';
import 'package:genetic_algorithms/shared/theme.dart';

import 'bar_item.dart';

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

  static Widget top(
    BuildContext context,
    TabBarBloc tabBarBloc,
    String appBarTitle, {
    double padding = Directions.screenPadding,
  }) {
    return BlocBuilder(
      bloc: tabBarBloc,
      builder: (context, state) {
        return DefaultTabController(
          length: tabBarBloc.tabLenght,
          initialIndex: tabBarBloc.index,
          child: Scaffold(
            appBar: AppBar(
              title: Text(appBarTitle),
              bottom: TabBar(
                tabs: [
                  for (TabItem tab in tabBarBloc.tabs)
                    Tab(
                      text: tab.getLabel(context),
                    )
                ],
              ),
            ),
            body: SafeArea(
              child: TabBarView(children: tabBarBloc.tabs),
            ),
          ),
        );
      },
    );
  }
}
