import 'package:flutter/material.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/algorithm_params_form_bloc.dart';
import 'package:genetic_algorithms/ui/components/bar_item.dart';
import 'package:genetic_algorithms/ui/components/form_bloc_builder.dart';

class GeneratePopulationTab extends TabItem {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBlocBuilder(
          AlgorithmParamsFormBloc(),
        ),
      ],
    );
  }

  @override
  Widget getIcon(BuildContext context) => Icon(Icons.grain_rounded);

  @override
  String getLabel(BuildContext context) => "Generate";
}
