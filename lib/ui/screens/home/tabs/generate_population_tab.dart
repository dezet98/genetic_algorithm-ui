import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/form/form_bloc.dart' as own;
import 'package:genetic_algorithms/blocs/specific_blocs/algorithm_params_form_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/result_save/result_save_bloc.dart';
import 'package:genetic_algorithms/shared/extensions.dart';
import 'package:genetic_algorithms/ui/components/bar_item.dart';
import 'package:genetic_algorithms/ui/components/custom_scnack_bar.dart';
import 'package:genetic_algorithms/ui/components/form_bloc_builder.dart';

class GeneratePopulationTab extends TabItem {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.bloc<ResultSaveBloc>(),
      listener: _resultSaveBlocListener,
      builder: (context, state) {
        return FormBlocBuilder(
          formBloc: context.bloc<AlgorithmParamsFormBloc>(),
          listener: _formBlocListener,
        );
      },
    );
  }

  void _resultSaveBlocListener(BuildContext context, ResultSaveState state) {
    if (state is ResultsSaveFailureState) {
      CustomSnackBar.simpleShow(context, "Error when save results", "Close");
    } else if (state is ResultsSaveSuccesfullState) {
      CustomSnackBar.simpleShow(context, "Results was succesfully saved", "Ok");
    }
  }

  void _formBlocListener(BuildContext context, own.FormState state) {
    if (state is own.FormSubmitFailureState) {
      CustomSnackBar.simpleShow(context, "Form failure, try again", "Close");
    } else if (state is own.FormSubmitSuccessState) {
      CustomSnackBar.simpleShow(context, "Form Success!!!", "Ok");
    }
  }

  @override
  Widget getIcon(BuildContext context) => Icon(Icons.grain_rounded);

  @override
  String getLabel(BuildContext context) => "Generate";
}
