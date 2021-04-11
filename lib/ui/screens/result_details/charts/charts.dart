import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/router/router_bloc.dart';
import 'package:genetic_algorithms/data/models/average_in_epoch.dart';
import 'package:genetic_algorithms/data/models/best_in_epoch.dart';
import 'package:genetic_algorithms/data/models/standard_deviation.dart';
import 'package:genetic_algorithms/shared/extensions.dart';
import 'package:genetic_algorithms/shared/routes.dart';
import 'package:genetic_algorithms/shared/theme.dart';
import 'package:genetic_algorithms/ui/components/bar_item.dart';
import 'package:genetic_algorithms/ui/screens/chart/chart_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartsTab extends TabItem {
  final List<BestInEpoch>? bestInEpochs;
  final List<AverageInEpoch>? averageInEpochs;
  final List<StandardDeviation>? standardDeviations;

  ChartsTab(
      {required this.bestInEpochs,
      required this.averageInEpochs,
      required this.standardDeviations});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(horizontal: Directions.screenPadding),
      child: Column(
        children: [
          for (var i = 0; i < charts.length; i++)
            Column(children: [
              Divider(),
              charts[i],
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: Directions.screenPadding),
                  child: TextButton(
                    onPressed: () {
                      goToChartScreen(context, chartsForChartScreen[i]);
                    },
                    child: Text('See more'),
                  ),
                ),
              ),
            ]),
          Divider(),
        ],
      ),
    );
  }

  List<SfCartesianChart> get charts =>
      [bestInEpochsChart(), averageInEpochChart(), standardDeviationChart()];

  List<SfCartesianChart> get chartsForChartScreen => [
        bestInEpochsChart(
            isPrimaryXAxis: true, isPrimaryYAxis: true, isTooltipEnable: true),
        averageInEpochChart(
            isPrimaryXAxis: true, isPrimaryYAxis: true, isTooltipEnable: true),
        standardDeviationChart(
            isPrimaryXAxis: true, isPrimaryYAxis: true, isTooltipEnable: true)
      ];

  SfCartesianChart bestInEpochsChart({
    bool isPrimaryXAxis = false,
    bool isPrimaryYAxis = false,
    bool isTooltipEnable = false,
  }) =>
      SfCartesianChart(
        title: ChartTitle(text: 'Best values ​​on the next epoch'),
        series: bestInEpochsSeries,
        tooltipBehavior: TooltipBehavior(enable: isTooltipEnable),
        enableAxisAnimation: true,
        primaryXAxis: isPrimaryXAxis
            ? NumericAxis(title: AxisTitle(text: 'Epoch'))
            : null,
        primaryYAxis: isPrimaryYAxis
            ? NumericAxis(title: AxisTitle(text: 'Best value'))
            : null,
      );

  SfCartesianChart averageInEpochChart({
    bool isPrimaryXAxis = false,
    bool isPrimaryYAxis = false,
    bool isTooltipEnable = false,
  }) =>
      SfCartesianChart(
        title: ChartTitle(text: 'Average values ​​on the next epoch'),
        series: averageInEpochSeries,
        tooltipBehavior: TooltipBehavior(enable: isTooltipEnable),
        primaryXAxis: isPrimaryXAxis
            ? NumericAxis(title: AxisTitle(text: 'Epoch'))
            : null,
        primaryYAxis: isPrimaryYAxis
            ? NumericAxis(title: AxisTitle(text: 'Average value'))
            : null,
      );

  SfCartesianChart standardDeviationChart({
    bool isPrimaryXAxis = false,
    bool isPrimaryYAxis = false,
    bool isTooltipEnable = false,
  }) =>
      SfCartesianChart(
        title: ChartTitle(text: 'The standard deviation on the next epoch'),
        series: standardDeviationSeries,
        tooltipBehavior: TooltipBehavior(enable: isTooltipEnable),
        primaryXAxis: isPrimaryXAxis
            ? NumericAxis(title: AxisTitle(text: 'Epoch'))
            : null,
        primaryYAxis: isPrimaryYAxis
            ? NumericAxis(title: AxisTitle(text: 'The standard deviation'))
            : null,
      );

  List<SplineSeries<BestInEpoch, num>> get bestInEpochsSeries => getDefaultData(
        dataSource: bestInEpochs!,
        xValueMapper: (BestInEpoch bestInEpoch, _) => bestInEpoch.epoch,
        yValueMapper: (BestInEpoch bestInEpoch, _) => bestInEpoch.value,
      );

  List<SplineSeries<AverageInEpoch, num>> get averageInEpochSeries =>
      getDefaultData(
        dataSource: averageInEpochs!,
        xValueMapper: (AverageInEpoch averageInEpoch, _) =>
            averageInEpoch.epoch,
        yValueMapper: (AverageInEpoch averageInEpoch, _) =>
            averageInEpoch.value,
      );

  List<SplineSeries<StandardDeviation, num>> get standardDeviationSeries =>
      getDefaultData(
        dataSource: standardDeviations!,
        xValueMapper: (StandardDeviation standardDeviation, int) =>
            standardDeviation.epoch,
        yValueMapper: (StandardDeviation standardDeviation, _) =>
            standardDeviation.value,
      );

  List<SplineSeries<DataType, num>> getDefaultData<DataType>({
    required List<DataType> dataSource,
    required num? Function(DataType, int) xValueMapper,
    required num? Function(DataType, int) yValueMapper,
  }) {
    return [
      SplineSeries<DataType, num>(
        dataSource: dataSource,
        xValueMapper: xValueMapper,
        yValueMapper: yValueMapper,
        width: 2,
        cardinalSplineTension: 0.9,
        splineType: SplineType.natural,
        dashArray: <double>[1, 3],
        markerSettings: MarkerSettings(
          isVisible: true,
          height: 4,
          width: 4,
          shape: DataMarkerType.circle,
          borderWidth: 3,
          borderColor: Colors.blue,
        ),
        // dataLabelSettings: DataLabelSettings(
        //   isVisible: true,
        //   labelPosition: ChartDataLabelPosition.outside,
        // ),
        xAxisName: "Epochs",
        yAxisName: "Best result",
        enableTooltip: true,
        // trendlines: [
        //   Trendline(
        //     color: Colors.black12,
        //     width: 1,
        //   )
        // ],
        name: "Seria",
      ),
    ];
  }

  void goToChartScreen(BuildContext context, Widget chart) {
    context.bloc<RouterBloc>().add(
          RouterNavigateToEvent(
            RouteName.CHART_SCREEN,
            routeArgs: ChartScreenArgs(chart: chart),
          ),
        );
  }

  @override
  Widget getIcon(BuildContext context) => Icon(Icons.bar_chart_sharp);

  @override
  String getLabel(BuildContext context) => "Charts";
}
