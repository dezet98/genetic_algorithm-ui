import 'dart:async';

import 'package:genetic_algorithms/blocs/abstract/local_database_get/local_database_get_bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/local_database_save/local_database_save_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/result/results_get_bloc.dart';
import 'package:genetic_algorithms/data/algorithm/result.dart';
import 'package:genetic_algorithms/data/models/algorithm_result.dart';
import 'package:genetic_algorithms/data/models/average_in_epoch.dart';
import 'package:genetic_algorithms/data/models/best_in_epoch.dart';
import 'package:genetic_algorithms/data/models/standard_deviation.dart';
import 'package:genetic_algorithms/data/services/local_database_service.dart';

class ResultSaveBloc extends LocalDatabaseSaveBloc<Result> {
  LocalDatabaseService _localDatabaseService;
  final ResultsGetBloc _resultsGetBloc;

  ResultSaveBloc(this._localDatabaseService, this._resultsGetBloc);

  @override
  Future<void> saveToDatabase(Result result) async {
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

    _resultsGetBloc.add(LocalDatabaseGetRefreshEvent());
  }
}
