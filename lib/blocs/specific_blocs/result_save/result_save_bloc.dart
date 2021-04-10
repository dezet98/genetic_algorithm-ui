import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genetic_algorithms/data/algorithm/result.dart';
import 'package:genetic_algorithms/data/services/local_database_service.dart';
import 'package:genetic_algorithms/shared/exceptions.dart';
import 'package:meta/meta.dart';

part 'result_save_event.dart';
part 'result_save_state.dart';

class ResultSaveBloc extends Bloc<ResultSaveEvent, ResultSaveState> {
  LocalDatabaseService _localDatabaseService;

  ResultSaveBloc(this._localDatabaseService) : super(ResultSaveInitialState());

  @override
  Stream<ResultSaveState> mapEventToState(
    ResultSaveEvent event,
  ) async* {
    if (event is ResultSaveToEvent) {
      yield* mapResultSaveToEvent(event._result);
    }
  }

  Stream<ResultSaveState> mapResultSaveToEvent(Result result) async* {
    try {
      yield ResultsSaveInProgressState();
      var resultId =
          await _localDatabaseService.insertQuery(result.resultTableInsert());
      await _localDatabaseService
          .insertQueries(result.bestEpochInsert(resultId));
      await _localDatabaseService
          .insertQueries(result.averageInEpochInsert(resultId));
      await _localDatabaseService
          .insertQueries(result.standardDeviationInsert(resultId));
      yield ResultsSaveSuccesfullState();
    } catch (e) {
      if (e is LocalDatabaseFailureException) {
        yield ResultsSaveFailureState(e.localDatabaseError, e.message);
      }
      yield ResultsSaveFailureState(LocalDatabaseError.UNDEFINED, e.toString());
    }
  }
}
