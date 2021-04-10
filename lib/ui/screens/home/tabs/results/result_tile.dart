import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/result_delete/result_delete_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/results/results_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/router/router_bloc.dart';
import 'package:genetic_algorithms/data/models/algorithm_result.dart';
import 'package:genetic_algorithms/shared/extensions.dart';
import 'package:genetic_algorithms/shared/routes.dart';
import 'package:genetic_algorithms/ui/screens/result_details/result_details_screen.dart';

class ResultTile extends StatelessWidget {
  final AlgorithmResult _algorithmResult;

  ResultTile(this._algorithmResult);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("Wynik numer " + _algorithmResult.resultId.toString()),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_algorithmResult.epochsAmount.toString() + " epok"),
            Text(_algorithmResult.populationSize.toString() + " osobników"),
            Text("Czas wykonania: " +
                _algorithmResult.algorithmTime +
                " sekund"),
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

  Widget resultsBuilder(BuildContext context, ResultDeleteState state) {
    if (state is ResultsDeleteInProgressState) {
      return LinearProgressIndicator();
    }

    return IconButton(
      icon: Icon(Icons.delete_forever_outlined),
      onPressed: () => deleteItem(context),
    );
  }

  void resultDeleteBlocListener(BuildContext context, ResultDeleteState state) {
    if (state is ResultsDeleteSuccesfullState) {
      context.bloc<ResultsBloc>().add(ResultsRefreshEvent());
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
        .add(ResultDeleteItemEvent(_algorithmResult));
  }
}
