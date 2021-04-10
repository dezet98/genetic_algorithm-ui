import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/info_tab_precision_bloc.dart';
import 'package:genetic_algorithms/data/models/average_in_epoch.dart';
import 'package:genetic_algorithms/data/models/best_in_epoch.dart';
import 'package:genetic_algorithms/data/models/standard_deviation.dart';
import 'package:genetic_algorithms/ui/components/bar_item.dart';

class DetailsTab extends TabItem {
  final List<BestInEpoch>? bestInEpochs;
  final List<AverageInEpoch>? averageInEpochs;
  final List<StandardDeviation>? standardDeviations;

  DetailsTab(
      {this.bestInEpochs, this.averageInEpochs, this.standardDeviations});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          getPresionPanel(context),
          BlocBuilder<InfoTabPrecisionBloc, int>(
            bloc: BlocProvider.of<InfoTabPrecisionBloc>(context),
            builder: (context, state) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: getTable(state),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget getPresionPanel(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              BlocProvider.of<InfoTabPrecisionBloc>(context).decrement();
            }),
        Text('Precision'),
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              BlocProvider.of<InfoTabPrecisionBloc>(context).increment();
            }),
      ],
    );
  }

  Widget getTable(int precision) {
    return DataTable(
      columns: [
        DataColumn(label: getRowText('epoch', italic: true)),
        DataColumn(label: getRowText('best', italic: true)),
        DataColumn(label: getRowText('average', italic: true)),
        DataColumn(label: getRowText('standard deviations', italic: true)),
      ],
      rows: [
        for (var i = 0; i < bestInEpochs!.length; i++)
          DataRow(
            cells: [
              DataCell(getRowText(i.toString())),
              DataCell(getCenterText(bestInEpochs![i].value, precision)),
              DataCell(getCenterText(averageInEpochs![i].value, precision)),
              DataCell(getCenterText(standardDeviations![i].value, precision)),
            ],
          ),
      ],
    );
  }

  Widget getRowText(String text, {bool? italic = false}) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontStyle: italic! ? FontStyle.italic : null,
        ),
      ),
    );
  }

  Widget getCenterText(double value, int precision) {
    return Center(
      child: Text(
        value.toStringAsFixed(precision),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget getIcon(BuildContext context) => Icon(Icons.table_chart_sharp);

  @override
  String getLabel(BuildContext context) => "Details";
}
