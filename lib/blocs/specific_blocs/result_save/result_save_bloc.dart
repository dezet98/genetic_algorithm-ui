import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genetic_algorithms/data/algorithm/result.dart';
import 'package:genetic_algorithms/data/models/algorithm_result.dart';
import 'package:genetic_algorithms/data/models/average_in_epoch.dart';
import 'package:genetic_algorithms/data/models/best_in_epoch.dart';
import 'package:genetic_algorithms/data/models/standard_deviation.dart';
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
      // _localDatabaseService.transaction((Transaction t) => save(t, result));
      var resultId = await _localDatabaseService
          .insertQuery(AlgorithmResult.saveToDatabase(result.algorithmResult));
      await _localDatabaseService.insertQueries(
        BestInEpoch.saveMultiToDatabase(result.bestInEpochs(resultId)),
      );
      await _localDatabaseService.insertQueries(
        AverageInEpoch.saveMultiToDatabase(result.averageInEpochs(resultId)),
      );
      await _localDatabaseService.insertQueries(
        StandardDeviation.saveMultiToDatabase(
            result.standardDeviations(resultId)),
      );
      yield ResultsSaveSuccesfullState();
    } catch (e) {
      if (e is LocalDatabaseFailureException) {
        yield ResultsSaveFailureState(e.localDatabaseError, e.message);
      }
      yield ResultsSaveFailureState(LocalDatabaseError.UNDEFINED, e.toString());
    }
  }

  // Future<void> save(Transaction transaction, Result result) async {

  // }
}
