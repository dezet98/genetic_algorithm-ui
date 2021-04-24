import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:genetic_algorithms/data/models/algorithm_params.dart';
import 'package:genetic_algorithms/ui/components/bar_item.dart';

class ParamsTab extends TabItem {
  final AlgorithmParams algorithmParams;

  ParamsTab(this.algorithmParams);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(children: [
        Column(
          children: [
            for (var i in getTiles()) Column(children: [Divider(), i]),
            Divider(),
          ],
        ),
      ]),
    );
  }

  List<Widget> getTiles() => [
        buildTile("Population", algorithmParams.populationAmount.toString()),
        buildTile("Epochs", algorithmParams.epochsAmount.toString()),
        buildTile("Start range", algorithmParams.startRange.toString()),
        buildTile("End range", algorithmParams.endRange.toString()),
        buildTile("Cross method", algorithmParams.cross.toString()),
        buildTile(
            "Cross probability", algorithmParams.crossProbability.toString()),
        buildTile("Selection method", algorithmParams.selection.toString()),
        buildTile("Selection probability",
            algorithmParams.selectionProbability.toString()),
        buildTile("Mutation method", algorithmParams.mutation.toString()),
        buildTile("Mutation probability",
            algorithmParams.mutationProbability.toString()),
        buildTile("Elite strategy amount",
            algorithmParams.eliteStrategyAmount.toString()),
        buildTile("Grade strategy", algorithmParams.gradeStrategy.toString()),
      ];

  Widget buildTile(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget getIcon(BuildContext context) => Icon(Icons.bar_chart_sharp);

  @override
  String getLabel(BuildContext context) => "Params";
}
