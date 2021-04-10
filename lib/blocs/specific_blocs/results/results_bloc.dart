import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genetic_algorithms/data/algorithm/result.dart';
import 'package:genetic_algorithms/data/services/local_database_service.dart';
import 'package:genetic_algorithms/shared/exceptions.dart';
import 'package:meta/meta.dart';

part 'results_event.dart';
part 'results_state.dart';

class ResultsBloc extends Bloc<ResultsEvent, ResultsState> {
  LocalDatabaseService _localDatabaseService;

  ResultsBloc(this._localDatabaseService) : super(ResultsInitialState()) {
    add(ResultsRefreshEvent());
  }

  @override
  Stream<ResultsState> mapEventToState(
    ResultsEvent event,
  ) async* {
    if (event is ResultsRefreshEvent) {
      yield* mapResultsRefreshEvent();
    }
  }

  Stream<ResultsState> mapResultsRefreshEvent() async* {
    try {
      yield ResultsLoadingInProgressState();
      var x = await _localDatabaseService.queryTable(Result.RESULT_DB_TABLE);
      print(x);
      var x2 = await _localDatabaseService.queryRows(
          Result.BEST_IN_EPOCH_DB_TABLE,
          Result.BEST_IN_EPOCH_DB_TABLE_RESULT_ID_DB_COLUMN,
          1);
      print(x2);
      var x3 = await _localDatabaseService.queryRows(
          Result.AVERAGE_IN_EPOCH_DB_TABLE,
          Result.AVERAGE_IN_EPOCH_DB_TABLE_RESULT_ID_DB_COLUMN,
          2);
      print(x3);
      var x4 = await _localDatabaseService.queryRows(
          Result.STANDARD_DEVIATION_DB_TABLE,
          Result.STANDARD_DEVIATION_DB_TABLE_RESULT_ID_DB_COLUMN,
          3);
      print(x4);
      await _localDatabaseService.closeDatabase();
      yield ResultsLoadingSuccesfullState();
    } catch (e) {
      if (e is LocalDatabaseFailureException) {
        yield ResultsLoadingFailureState(e.localDatabaseError, e.message);
      }
      yield ResultsLoadingFailureState(
          LocalDatabaseError.UNDEFINED, e.toString());
    }
  }
}
