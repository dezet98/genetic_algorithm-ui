import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/form/form_bloc.dart' as own;
import 'package:genetic_algorithms/blocs/abstract/local_database_save/local_database_save_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/forms/algorithm_params_form_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/result/result_save_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/router/router_bloc.dart';
import 'package:genetic_algorithms/data/algorithm/result.dart';
import 'package:genetic_algorithms/shared/extensions.dart';
import 'package:genetic_algorithms/shared/routes.dart';
import 'package:genetic_algorithms/ui/components/bar_item.dart';
import 'package:genetic_algorithms/ui/components/custom_scnack_bar.dart';
import 'package:genetic_algorithms/ui/components/form_bloc_builder.dart';
import 'package:genetic_algorithms/ui/screens/result_details/result_details_screen.dart';

class GeneratePopulationTab extends TabItem {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.bloc<ResultSaveBloc>(),
      listener: _resultSaveBlocListener,
      builder: (context, state) {
        return FormBlocBuilder(
          formBloc: context.bloc<AlgorithmParamsFormBloc>(),
          listener: _algorithmParamsFormBlocListener,
        );
      },
    );
  }

  void _resultSaveBlocListener(
      BuildContext context, LocalDatabaseSaveState state) {
    if (state is LocalDatabaseSaveFailureState) {
      CustomSnackBar.simpleShow(context, "Error when save results", "Close");
    }
  }

  void _algorithmParamsFormBlocListener(
      BuildContext context, own.FormState state) {
    if (state is own.FormSubmitFailureState) {
      CustomSnackBar.simpleShow(context, "Form failure, try again", "Close");
    } else if (state is own.FormSubmitSuccessState) {
      Result result = state.result;
      context.bloc<RouterBloc>().add(
            RouterNavigateToEvent(
              RouteName.RESULTS_DETAILS,
              routeArgs: ResultDetailsScreenArgs(
                algorithmResult: result.algorithmResult,
                averageInEpochs: result.averageInEpochs(null),
                bestInEpochs: result.bestInEpochs(null),
                standardDeviations: result.standardDeviations(null),
              ),
            ),
          );
    }
  }

  @override
  Widget getIcon(BuildContext context) => Icon(Icons.grain_rounded);

  @override
  String getLabel(BuildContext context) => "Generate";
}
