import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genetic_algorithms/blocs/abstract/local_database_get/local_database_get_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/result/results_get_bloc.dart';
import 'package:genetic_algorithms/data/models/algorithm_result.dart';
import 'package:genetic_algorithms/shared/extensions.dart';
import 'package:genetic_algorithms/ui/components/bar_item.dart';
import 'package:genetic_algorithms/ui/components/database_get_builder.dart';
import 'package:genetic_algorithms/ui/screens/home/tabs/results/result_tile.dart';

class ResultsTab extends TabItem {
  @override
  Widget build(BuildContext context) {
    return DatabaseGetBuilder(
      localDatabaseGetBloc: context.bloc<ResultsGetBloc>(),
      successBuilder: successBuilder,
      refreshAction: () => refreshAction(context),
    );
  }

  Widget successBuilder(
      BuildContext context, LocalDatabaseGetSuccesfullState state) {
    List<AlgorithmResult> algorithmResults =
        (state as LocalDatabaseGetSuccesfullState<List<AlgorithmResult>>)
            .results;
    return Scaffold(
      body: ListView.builder(
        itemCount: algorithmResults.length,
        itemBuilder: (context, index) {
          return ResultTile(algorithmResults[index]);
        },
      ),
      floatingActionButton:
          DatabaseGetBuilder.refreshButton(() => refreshAction(context)),
    );
  }

  void refreshAction(BuildContext context) {
    context.bloc<ResultsGetBloc>().add(LocalDatabaseGetRefreshEvent());
  }

  @override
  Widget getIcon(BuildContext context) => Icon(Icons.ac_unit_outlined);

  @override
  String getLabel(BuildContext context) => "Results";
}
