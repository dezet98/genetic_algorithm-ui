import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/local_database_delete/local_database_delete_bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/local_database_get/local_database_get_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/result/result_delete_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/result/results_get_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/router/router_bloc.dart';
import 'package:genetic_algorithms/data/algorithm/grade_strategy.dart';
import 'package:genetic_algorithms/data/models/algorithm_params.dart';
import 'package:genetic_algorithms/data/models/algorithm_result.dart';
import 'package:genetic_algorithms/shared/extensions.dart';
import 'package:genetic_algorithms/shared/routes.dart';
import 'package:genetic_algorithms/ui/components/custom_scnack_bar.dart';
import 'package:genetic_algorithms/ui/screens/result_details/result_details_screen.dart';

class ResultTile extends StatelessWidget {
  final AlgorithmResult _algorithmResult;

  ResultTile(this._algorithmResult);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            child: Text("${_algorithmResult.resultId}"),
          ),
          title: Text("${_algorithmResult.best}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Time: " + _algorithmResult.creationTime.toString()),
              Text("Execution time: " +
                  _algorithmResult.algorithmTime +
                  " seconds"),
            ],
          ),
          trailing: BlocConsumer(
            bloc: context.bloc<ResultDeleteBloc>(),
            listener: resultDeleteBlocListener,
            builder: (context, state) {
              return IconButton(
                icon: Icon(Icons.delete_forever_outlined),
                onPressed: () => deleteItem(context),
              );
            },
          ),
          onTap: () => goToResultDetails(context),
        ),
        if (_algorithmResult.algorithmParams != null)
          buildChips(_algorithmResult.algorithmParams!)
      ],
    );
  }

  Widget resultsBuilder(BuildContext context, LocalDatabaseDeleteState state) {
    if (state is LocalDatabaseDeleteInProgressState) {
      return LinearProgressIndicator();
    }

    return IconButton(
      icon: Icon(Icons.delete_forever_outlined),
      onPressed: () => deleteItem(context),
    );
  }

  Widget buildChips(AlgorithmParams algorithmParams) {
    return Wrap(
      children: [
        buildChip("Population(${algorithmParams.populationAmount})",
            color: Colors.red.shade50),
        buildChip("Epochs(${algorithmParams.epochsAmount})",
            color: Colors.blue.shade50),
        buildChip(
            "<${algorithmParams.startRange}, ${algorithmParams.endRange}>",
            color: Colors.orange.shade50),
        buildChip(
            algorithmParams.cross.toString() +
                "(${algorithmParams.crossProbability * 100}%)",
            color: Colors.pink.shade50),
        buildChip(
            algorithmParams.selection.toString() +
                "(${algorithmParams.selectionProbability * 100}%)",
            color: Colors.green.shade50),
        buildChip(
            algorithmParams.mutation.toString() +
                "(${algorithmParams.mutationProbability * 100}%)",
            color: Colors.yellow.shade50),
        buildChip("EliteStrategy(${algorithmParams.eliteStrategyAmount})",
            color: Colors.purple.shade50),
        buildChip(
            "GradeStratefy(${GradeStrategy.text(algorithmParams.gradeStrategy)})",
            color: Colors.amber.shade50),
      ],
      alignment: WrapAlignment.start,
      spacing: 10.0,
      runSpacing: -10.0,
    );
  }

  Widget buildChip(String labelText, {Color? color}) {
    return Chip(
      label: Text(labelText),
      backgroundColor: color,
    );
  }

  void resultDeleteBlocListener(
      BuildContext context, LocalDatabaseDeleteState state) {
    if (state is LocalDatabaseDeleteSuccesfullState) {
      context.bloc<ResultsGetBloc>().add(LocalDatabaseGetRefreshEvent());
    } else if (state is LocalDatabaseDeleteFailureState) {
      CustomSnackBar.simpleShow(context,
          " Deleting error: ${state.error}\n ${state.message}", "Close");
    }
  }

  void goToResultDetails(BuildContext context) {
    context.bloc<RouterBloc>().add(
          RouterNavigateToEvent(
            RouteName.RESULTS_DETAILS,
            routeArgs:
                ResultDetailsScreenArgs(algorithmResult: _algorithmResult),
          ),
        );
  }

  void deleteItem(BuildContext context) {
    context
        .bloc<ResultDeleteBloc>()
        .add(LocalDatabaseDeleteDataEvent(_algorithmResult));
  }
}
