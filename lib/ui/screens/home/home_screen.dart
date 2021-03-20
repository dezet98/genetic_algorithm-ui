import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/router/router_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: RouterBloc(),
      listener: routerBlocListener,
      child: Scaffold(
        backgroundColor: Colors.red,
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text("Click"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void routerBlocListener(BuildContext context, RouterState state) {
  if (state is RouterChangeRouteState) {
    Navigator.push(context, state.route);
  }
}
