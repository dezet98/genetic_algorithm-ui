import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/change_chart_data_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/router/router_bloc.dart';

enum ChartType { singleChart, dynamicChart }

class ChartScreenArgs extends RouteArgs {
  Widget? chart;
  late final ChartType type;

  List<Widget>? charts;
  int? initialSeriesIndex;

  ChartScreenArgs.chart({required this.chart}) {
    type = ChartType.singleChart;
  }

  ChartScreenArgs.dynamicChart({
    required this.charts,
    required this.initialSeriesIndex,
  }) {
    type = ChartType.dynamicChart;
  }
}

class ChartScreen extends StatelessWidget {
  final ChartScreenArgs args;

  ChartScreen(this.args);

  @override
  Widget build(BuildContext context) {
    switch (args.type) {
      case ChartType.singleChart:
        return buildSingleChart(args.chart!);
      case ChartType.dynamicChart:
        return BlocProvider(
          create: (context) => ChangeChartDataBloc(
            args.charts!.length,
            args.initialSeriesIndex!,
          ),
          child: Builder(
            builder: (context) => buildDynamicChart(
              context,
              args.charts!,
            ),
          ),
        );
    }
  }

  Widget buildSingleChart<DataType>(Widget chart) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          chart,
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

Widget buildDynamicChart<DataType>(BuildContext context, List<Widget> charts) {
  return Scaffold(
    appBar: AppBar(
      title: BlocBuilder<ChangeChartDataBloc, int>(
        bloc: BlocProvider.of<ChangeChartDataBloc>(context),
        builder: (context, state) {
          return Text(
              "Chart ${BlocProvider.of<ChangeChartDataBloc>(context).state + 1} / ${BlocProvider.of<ChangeChartDataBloc>(context).lenght}");
        },
      ),
      actions: [
        IconButton(
          onPressed: () {
            BlocProvider.of<ChangeChartDataBloc>(context).back();
          },
          icon: Text("Back"),
        ),
        IconButton(
          onPressed: () {
            BlocProvider.of<ChangeChartDataBloc>(context).next();
          },
          icon: Text("Next"),
        )
      ],
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: BlocBuilder<ChangeChartDataBloc, int>(
          bloc: BlocProvider.of<ChangeChartDataBloc>(context),
          builder: (context, state) {
            return charts[BlocProvider.of<ChangeChartDataBloc>(context).state];
          },
        ),
      ),
    ),
  );
}

class ChartSeries<DataType> {
  final num? Function(DataType, int) valueMapper;
  final axisName;

  ChartSeries(this.valueMapper, this.axisName);
}
