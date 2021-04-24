import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genetic_algorithms/blocs/abstract/local_database_get/local_database_get_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/result/results_get_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/router/router_bloc.dart';
import 'package:genetic_algorithms/data/algorithm/grade_strategy.dart';
import 'package:genetic_algorithms/data/algorithm/selection.dart';
import 'package:genetic_algorithms/data/models/algorithm_params.dart';
import 'package:genetic_algorithms/data/models/algorithm_result.dart';
import 'package:genetic_algorithms/shared/extensions.dart';
import 'package:genetic_algorithms/shared/routes.dart';
import 'package:genetic_algorithms/shared/theme.dart';
import 'package:genetic_algorithms/ui/components/bar_item.dart';
import 'package:genetic_algorithms/ui/components/database_get_builder.dart';
import 'package:genetic_algorithms/ui/screens/chart/chart_screen.dart';
import 'package:genetic_algorithms/ui/screens/home/tabs/results/result_tile.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ResultsTab extends TabItem {
  @override
  Widget build(BuildContext context) {
    return DatabaseGetBuilder(
      localDatabaseGetBloc: context.bloc<ResultsGetBloc>(),
      successBuilder: successBuilder,
      refreshAction: () => refreshAction(context),
    );
  }

  Widget successBuilder(
      BuildContext context, LocalDatabaseGetSuccesfullState state) {
    List<AlgorithmResult> algorithmResults =
        (state as LocalDatabaseGetSuccesfullState<List<AlgorithmResult>>)
            .results;
    return Scaffold(
      body: ListView.builder(
        itemCount: algorithmResults.length,
        itemBuilder: (context, index) {
          return ResultTile(algorithmResults[index]);
        },
      ),
      floatingActionButton: Wrap(children: [
        Column(
          children: [
            buildChartsButton(context, algorithmResults),
            SizedBox(height: Directions.screenPadding),
            DatabaseGetBuilder.refreshButton(() => refreshAction(context)),
          ],
        )
      ]),
    );
  }

  void refreshAction(BuildContext context) {
    context.bloc<ResultsGetBloc>().add(LocalDatabaseGetRefreshEvent());
  }

  Widget buildChartsButton(
      BuildContext context, List<AlgorithmResult> algorithmResults) {
    return FloatingActionButton(
      child: Icon(Icons.show_chart_sharp),
      heroTag: "show_chart_sharp",
      onPressed: () {
        context.bloc<RouterBloc>().add(
              RouterNavigateToEvent(
                RouteName.CHART_SCREEN,
                routeArgs: ChartScreenArgs.dynamicChart(
                  charts: [
                    epochsAmountBestChart(algorithmResults),
                    populationAmountBestChart(algorithmResults),
                    creationTimeBestMaximalChart(algorithmResults),
                    creationTimeBestMinimalChart(algorithmResults),
                  ],
                  initialSeriesIndex: 0,
                ),
              ),
            );
      },
    );
  }

  List<Color> get colors => [Colors.blue, Colors.red, Colors.yellow];

  Widget epochsAmountBestChart(List<AlgorithmResult> algorithmResults) {
    return SfCartesianChart(
      legend: legendForSelection,
      tooltipBehavior: tooltipBehavior,
      series: getDefaultData(
        dataSources: seriesForSelection(algorithmResults),
        dataSourcesColors: colorsForSelection,
        xValueMapper: (v, _) =>
            (v as AlgorithmResult).algorithmParams!.epochsAmount,
        yValueMapper: (v, _) => (v as AlgorithmResult).best,
      ),
      primaryXAxis: NumericAxis(title: AxisTitle(text: "epochs amount")),
      primaryYAxis: NumericAxis(title: AxisTitle(text: "best")),
    );
  }

  Widget populationAmountBestChart(List<AlgorithmResult> algorithmResults) {
    return SfCartesianChart(
      legend: legendForSelection,
      tooltipBehavior: tooltipBehavior,
      series: getDefaultData(
        dataSources: seriesForSelection(algorithmResults),
        dataSourcesColors: colorsForSelection,
        xValueMapper: (v, _) =>
            (v as AlgorithmResult).algorithmParams!.populationAmount,
        yValueMapper: (v, _) => (v as AlgorithmResult).best,
      ),
      primaryXAxis: NumericAxis(title: AxisTitle(text: "population amount")),
      primaryYAxis: NumericAxis(title: AxisTitle(text: "best")),
    );
  }

  Widget creationTimeBestMaximalChart(List<AlgorithmResult> algorithmResults) {
    return SfCartesianChart(
      tooltipBehavior: tooltipBehavior,
      title: ChartTitle(text: "For maximal grade"),
      series: getDefaultData(
        dataSources: [
          algorithmResults
              .where((element) => element.algorithmParams!.gradeStrategy)
              .toList(),
        ],
        dataSourcesColors: [Colors.blue],
        xValueMapper: (v, _) => (v as AlgorithmResult).creationTime.second,
        yValueMapper: (v, _) => (v as AlgorithmResult).best,
      ),
      primaryXAxis: NumericAxis(title: AxisTitle(text: "seconds")),
      primaryYAxis: NumericAxis(title: AxisTitle(text: "best")),
    );
  }

  Widget creationTimeBestMinimalChart(List<AlgorithmResult> algorithmResults) {
    return SfCartesianChart(
      tooltipBehavior: tooltipBehavior,
      title: ChartTitle(text: "For minimal grade"),
      series: getDefaultData(
        dataSources: [
          algorithmResults
              .where((element) => !element.algorithmParams!.gradeStrategy)
              .toList(),
        ],
        dataSourcesColors: [Colors.blue],
        xValueMapper: (v, _) => (v as AlgorithmResult).creationTime.second,
        yValueMapper: (v, _) => (v as AlgorithmResult).best,
      ),
      primaryXAxis: NumericAxis(title: AxisTitle(text: "seconds")),
      primaryYAxis: NumericAxis(title: AxisTitle(text: "best")),
    );
  }

  List<ScatterSeries<dynamic, num>> getDefaultData({
    required List<List<dynamic>> dataSources,
    required List<Color> dataSourcesColors,
    required num? Function(dynamic, int) xValueMapper,
    required num? Function(dynamic, int) yValueMapper,
  }) {
    return [
      for (var i = 0; i < dataSources.length; i++)
        ScatterSeries<dynamic, num>(
          dataSource: dataSources[i],
          xValueMapper: xValueMapper,
          yValueMapper: yValueMapper,
          markerSettings: MarkerSettings(
            isVisible: true,
            height: 6,
            width: 6,
            shape: DataMarkerType.circle,
            borderWidth: 8,
            borderColor: dataSourcesColors[i],
          ),
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.inside,
          ),
          enableTooltip: true,
        ),
    ];
  }

  List<List<dynamic>> seriesForSelection(
          List<AlgorithmResult> algorithmResults) =>
      [
        for (var i in Selection.items)
          algorithmResults
              .where((element) => element.algorithmParams!.selection == i)
              .toList(),
      ];

  List<Color> get colorsForSelection =>
      colors.sublist(0, Selection.items.length);

  Legend get legendForSelection => Legend(
        orientation: LegendItemOrientation.vertical,
        isVisible: true,
        title: LegendTitle(text: "Selection method"),
        position: LegendPosition.auto,
        legendItemBuilder: (legendText, series, point, seriesIndex) {
          return Container(
            height: 30,
            width: 80,
            child: Row(
              children: [
                Container(
                    height: 10,
                    width: 10,
                    color: colorsForSelection[seriesIndex]),
                SizedBox(width: 5),
                Container(
                  child: Text(Selection.text(Selection.items[seriesIndex])),
                ),
              ],
            ),
          );
        },
      );

  TooltipBehavior get tooltipBehavior => TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        return buildChips((data as AlgorithmResult).algorithmParams!);
      });

  Widget buildChips(AlgorithmParams algorithmParams) {
    return Wrap(
      children: [
        buildChip("Population(${algorithmParams.populationAmount})",
            color: Colors.red.shade50),
        buildChip("Epochs(${algorithmParams.epochsAmount})",
            color: Colors.blue.shade50),
        buildChip(
            "<${algorithmParams.startRange}, ${algorithmParams.endRange}>",
            color: Colors.orange.shade50),
        buildChip(
            algorithmParams.cross.toString() +
                "(${algorithmParams.crossProbability * 100}%)",
            color: Colors.pink.shade50),
        buildChip(
            algorithmParams.selection.toString() +
                "(${algorithmParams.selectionProbability * 100}%)",
            color: Colors.green.shade50),
        buildChip(
            algorithmParams.mutation.toString() +
                "(${algorithmParams.mutationProbability * 100}%)",
            color: Colors.yellow.shade50),
        buildChip("EliteStrategy(${algorithmParams.eliteStrategyAmount})",
            color: Colors.purple.shade50),
        buildChip(
            "GradeStratefy(${GradeStrategy.text(algorithmParams.gradeStrategy)})",
            color: Colors.amber.shade50),
      ],
      alignment: WrapAlignment.start,
      spacing: 10.0,
      runSpacing: -10.0,
    );
  }

  Widget buildChip(String labelText, {Color? color}) {
    return Chip(
      label: Text(labelText),
      backgroundColor: color,
    );
  }

  @override
  Widget getIcon(BuildContext context) => Icon(Icons.ac_unit_outlined);

  @override
  String getLabel(BuildContext context) => "Results";
}
