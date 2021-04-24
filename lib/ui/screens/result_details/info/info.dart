import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:genetic_algorithms/data/models/algorithm_result.dart';
import 'package:genetic_algorithms/ui/components/bar_item.dart';

class InfoTab extends TabItem {
  final AlgorithmResult algorithmResult;

  InfoTab(this.algorithmResult);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildTile("Creation date", algorithmResult.creationTime.toString()),
        buildTile("Population",
            algorithmResult.algorithmParams!.populationAmount.toString()),
        buildTile(
            "Epochs", algorithmResult.algorithmParams!.epochsAmount.toString()),
        buildTile("Best result", algorithmResult.best.toString()),
        buildTile("Result average", algorithmResult.bestAverage.toString()),
        buildTile("Time", algorithmResult.algorithmTime),
      ],
    );
  }

  Widget buildTile(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget getIcon(BuildContext context) => Icon(Icons.bar_chart_sharp);

  @override
  String getLabel(BuildContext context) => "Basic Info";
}
