import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/local_database_delete/local_database_delete_bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/local_database_get/local_database_get_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/result/result_delete_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/result/results_get_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/router/router_bloc.dart';
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
    return Card(
      child: ListTile(
        title: Text("Result number " + _algorithmResult.resultId.toString()),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_algorithmResult.epochsAmount.toString() + " epochs"),
            Text(_algorithmResult.populationSize.toString() + " population"),
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
