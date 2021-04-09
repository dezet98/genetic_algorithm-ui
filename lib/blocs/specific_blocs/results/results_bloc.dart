import 'dart:async';

import 'package:bloc/bloc.dart';
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
      await _localDatabaseService.queryTable("RESULT");
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
