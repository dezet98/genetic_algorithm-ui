import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/result_delete/result_delete_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/results/results_bloc.dart';
import 'package:genetic_algorithms/shared/extensions.dart';

class ResultTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("Daniel"),
        subtitle: Text("Date"),
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
        onTap: () => goToResultDetails(),
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

  void goToResultDetails() {}

  void deleteItem(BuildContext context) {
    context.bloc<ResultDeleteBloc>().add(ResultDeleteItemEvent());
  }
}
