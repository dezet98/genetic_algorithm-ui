import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genetic_algorithms/ui/components/bar_item.dart';

class ResultsTab extends TabItem {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Widget getIcon(BuildContext context) => Icon(Icons.ac_unit_outlined);

  @override
  String getLabel(BuildContext context) => "Results";
}
