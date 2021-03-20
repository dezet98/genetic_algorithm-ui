import 'package:flutter/material.dart';
import 'package:genetic_algorithms/ui/components/bar_item.dart';

class GeneratePopulationTab extends TabItem {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red);
  }

  @override
  Widget getIcon(BuildContext context) => Icon(Icons.ac_unit_outlined);

  @override
  String getLabel(BuildContext context) => "Hello";
}
