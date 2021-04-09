import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/results/results_bloc.dart';
import 'package:genetic_algorithms/shared/exceptions.dart';
import 'package:genetic_algorithms/shared/extensions.dart';
import 'package:genetic_algorithms/ui/components/bar_item.dart';
import 'package:genetic_algorithms/ui/screens/home/tabs/results/result_tile.dart';

class ResultsTab extends TabItem {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.bloc<ResultsBloc>(),
      builder: resultsBuilder,
      listener: (context, state) {},
    );
  }

  Widget resultsBuilder(BuildContext context, ResultsState state) {
    if (state is ResultsLoadingInProgressState) {
      return inProgressWidget(state);
    } else if (state is ResultsInitialState) {
      return initialWidget(state);
    } else if (state is ResultsLoadingSuccesfullState)
      return successWidget(context, state);

    return failureWidget(context, state as ResultsLoadingFailureState);
  }

  Widget initialWidget(ResultsInitialState state) {
    return Center(child: CircularProgressIndicator());
  }

  Widget inProgressWidget(ResultsLoadingInProgressState state) {
    return Center(child: CircularProgressIndicator());
  }

  Widget failureWidget(BuildContext context, ResultsLoadingFailureState state) {
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
    }
  }

  Widget successWidget(
      BuildContext context, ResultsLoadingSuccesfullState state) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return ResultTile();
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
    context.bloc<ResultsBloc>().add(ResultsRefreshEvent());
  }

  @override
  Widget getIcon(BuildContext context) => Icon(Icons.ac_unit_outlined);

  @override
  String getLabel(BuildContext context) => "Results";
}
