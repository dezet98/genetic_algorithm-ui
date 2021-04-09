import 'dart:async';

import 'package:bloc/bloc.dart';
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
      yield* mapResultDeleteItemEvent();
    }
  }

  Stream<ResultDeleteState> mapResultDeleteItemEvent() async* {
    try {
      yield ResultsDeleteInProgressState();

      // Implement delete

      yield ResultsDeleteSuccesfullState();
    } catch (e) {
      if (e is LocalDatabaseFailureException) {
        yield ResultsDeleteFailureState(e.localDatabaseError, e.message);
      }
      yield ResultsDeleteFailureState(
          LocalDatabaseError.UNDEFINED, e.toString());
    }
  }
}
