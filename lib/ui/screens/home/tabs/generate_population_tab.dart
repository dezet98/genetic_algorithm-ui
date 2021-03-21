import 'package:flutter/material.dart';
import 'package:genetic_algorithms/blocs/abstract/field/field_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/algorithm_params_form_bloc.dart';
import 'package:genetic_algorithms/shared/extensions.dart';
import 'package:genetic_algorithms/ui/components/bar_item.dart';
import 'package:genetic_algorithms/ui/components/field_bloc_builder.dart';
import 'package:genetic_algorithms/ui/components/form_bloc_builder.dart';

class GeneratePopulationTab extends TabItem {
  @override
  Widget build(BuildContext context) {
    return FormBlocBuilder(
        formBloc: context.bloc<AlgorithmParamsFormBloc>(),
        formBuilder: formBuilder);
  }

  Widget formBuilder(List<FieldBloc<dynamic>> fieldBlocs,
      ButtonStyleButton submitButton, bool enabled) {
    return Column(
      children: [
        Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Genetic Algorithm for finding max/min in choosen function. Fill form ;)",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return FormBlocBuilder.formFieldTile(
                index == fieldBlocs.length
                    ? submitButton
                    : FieldBlocBuilder.getField(
                        fieldBlocs[index], enabled, context),
              );
            },
            itemCount: fieldBlocs.length + 1,
          ),
        ),
      ],
    );
  }

  @override
  Widget getIcon(BuildContext context) => Icon(Icons.grain_rounded);

  @override
  String getLabel(BuildContext context) => "Generate";
}
