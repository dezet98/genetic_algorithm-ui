import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/local_database_get/local_database_get_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/result/results_get_bloc.dart';
import 'package:genetic_algorithms/data/models/algorithm_result.dart';
import 'package:genetic_algorithms/shared/exceptions.dart';
import 'package:genetic_algorithms/shared/extensions.dart';
import 'package:genetic_algorithms/ui/components/bar_item.dart';
import 'package:genetic_algorithms/ui/screens/home/tabs/results/result_tile.dart';

class ResultsTab extends TabItem {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.bloc<ResultsGetBloc>(),
      builder: resultsBuilder,
      listener: (context, state) {},
    );
  }

  Widget resultsBuilder(BuildContext context, LocalDatabaseGetState state) {
    if (state is LocalDatabaseGetInProgressState) {
      return inProgressWidget(state);
    } else if (state is LocalDatabaseGetInitialState) {
      return initialWidget(state);
    } else if (state is LocalDatabaseGetSuccesfullState<List<AlgorithmResult>>)
      return successWidget(context, state);

    return failureWidget(context, state as LocalDatabaseGetFailureState);
  }

  Widget initialWidget(LocalDatabaseGetInitialState state) {
    return Center(child: CircularProgressIndicator());
  }

  Widget inProgressWidget(LocalDatabaseGetInProgressState state) {
    return Center(child: CircularProgressIndicator());
  }

  Widget failureWidget(
      BuildContext context, LocalDatabaseGetFailureState state) {
    return Center(
      child: Column(
        children: [
          Text('Error'),
          Text(getTextFromError(state.error)),
          if (state.message != null) Text(state.message!),
          ElevatedButton(
            onPressed: () => refreshAction(context),
            child: Icon(Icons.refresh_rounded),
          ),
        ],
      ),
    );
  }

  String getTextFromError(LocalDatabaseError error) {
    switch (error) {
      case LocalDatabaseError.UNDEFINED:
        return "UNDEFINED";
      case LocalDatabaseError.GET_FROM_DATABASE_CAST_ERROR:
        return "GET_FROM_DATABASE_CAST_ERROR";
      case LocalDatabaseError.DELETE_ERROR:
        return "DELETE_ERROR";
      default:
        return "UNDEFINED";
    }
  }

  Widget successWidget(BuildContext context,
      LocalDatabaseGetSuccesfullState<List<AlgorithmResult>> state) {
    return Scaffold(
      body: ListView.builder(
        itemCount: state.results.length,
        itemBuilder: (context, index) {
          return ResultTile(state.results[index]);
        },
      ),
      floatingActionButton: refreshButton(context),
    );
  }

  Widget refreshButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.refresh),
      onPressed: () {
        refreshAction(context);
      },
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
