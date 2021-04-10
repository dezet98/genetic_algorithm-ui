import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genetic_algorithms/data/models/algorithm_result.dart';
import 'package:genetic_algorithms/data/services/local_database_service.dart';
import 'package:genetic_algorithms/shared/exceptions.dart';
import 'package:meta/meta.dart';

part 'result_delete_event.dart';
part 'result_delete_state.dart';

class ResultDeleteBloc extends Bloc<ResultDeleteEvent, ResultDeleteState> {
  LocalDatabaseService _localDatabaseService;

  ResultDeleteBloc(this._localDatabaseService) : super(ResultDeleteInitial());

  @override
  Stream<ResultDeleteState> mapEventToState(
    ResultDeleteEvent event,
  ) async* {
    if (event is ResultDeleteItemEvent) {
      yield* mapResultDeleteItemEvent(event._algorithmResult);
    }
  }

  Stream<ResultDeleteState> mapResultDeleteItemEvent(
      AlgorithmResult algorithmResult) async* {
    try {
      yield ResultsDeleteInProgressState();

      if (algorithmResult.resultId != null) {
        await _localDatabaseService.delete(AlgorithmResult.dbTable.name,
            AlgorithmResult.dbResultId.name, algorithmResult.resultId);
        yield ResultsDeleteSuccesfullState();
      } else {
        yield ResultsDeleteFailureState(LocalDatabaseError.DELETE_ERROR, "");
      }
    } catch (e) {
      if (e is LocalDatabaseFailureException) {
        yield ResultsDeleteFailureState(e.localDatabaseError, e.message);
      }
      yield ResultsDeleteFailureState(
          LocalDatabaseError.UNDEFINED, e.toString());
    }
  }
}
