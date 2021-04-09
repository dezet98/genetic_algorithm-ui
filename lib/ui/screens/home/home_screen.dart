import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/home_screen_tab_bar_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/router/router_bloc.dart';
import 'package:genetic_algorithms/shared/extensions.dart';
import 'package:genetic_algorithms/ui/components/screen_builders.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: context.bloc<RouterBloc>(),
      listener: routerBlocListener,
      child:
          ScreenWithBar.bottom(context, HomeScreenTabBarBloc(), padding: 0.0),
    );
  }
}

void routerBlocListener(BuildContext context, RouterState state) {
  if (state is RouterChangeRouteState) {
    Navigator.push(context, state.route);
  } else if (state is RouterBackState) {
    Navigator.pop(context);
  }
}
