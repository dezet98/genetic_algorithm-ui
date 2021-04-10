import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:genetic_algorithms/ui/components/bar_item.dart';

class ChartsTab extends TabItem {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }

  @override
  Widget getIcon(BuildContext context) => Icon(Icons.bar_chart_sharp);

  @override
  String getLabel(BuildContext context) => "Charts";
}
