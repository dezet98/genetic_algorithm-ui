import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/router/router_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/tab_bars/home_screen_tab_bar_bloc.dart';
import 'package:genetic_algorithms/shared/extensions.dart';
import 'package:genetic_algorithms/ui/components/custom_scnack_bar.dart';
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
  if (state is RouterChangeRouteSuccessState) {
    Navigator.push(context, state.route);
  } else if (state is RouterBackState) {
    Navigator.pop(context);
  } else if (state is RouterChangeRouteFailureState) {
    CustomSnackBar.simpleShow(context,
        "Navigation Error: ${state.routerError}\n ${state.message}", "Close");
  }
}
