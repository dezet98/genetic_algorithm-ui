import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/router/router_bloc.dart';

class ChartScreenArgs extends RouteArgs {
  final Widget chart;

  ChartScreenArgs({required this.chart});
}

class ChartScreen extends StatelessWidget {
  final ChartScreenArgs args;

  ChartScreen(this.args);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          args.chart,
          Align(
            alignment: Alignment.topLeft,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.transparent,
              onPressed: null,
              child: BackButton(),
            ),
          ),
        ]),
      ),
    );
  }
}
