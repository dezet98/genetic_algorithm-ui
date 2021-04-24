import 'dart:async';

import 'package:genetic_algorithms/blocs/abstract/local_database_get/local_database_get_bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/local_database_save/local_database_save_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/result/results_get_bloc.dart';
import 'package:genetic_algorithms/data/algorithm/result.dart';
import 'package:genetic_algorithms/data/models/algorithm_params.dart';
import 'package:genetic_algorithms/data/models/algorithm_result.dart';
import 'package:genetic_algorithms/data/models/average_in_epoch.dart';
import 'package:genetic_algorithms/data/models/best_in_epoch.dart';
import 'package:genetic_algorithms/data/models/standard_deviation.dart';
import 'package:genetic_algorithms/data/services/local_database_service.dart';

class ResultSaveBlocArgs {
  Result result;
  AlgorithmParams params;

  ResultSaveBlocArgs(this.result, this.params);
}

class ResultSaveBloc extends LocalDatabaseSaveBloc<ResultSaveBlocArgs> {
  LocalDatabaseService _localDatabaseService;
  final ResultsGetBloc _resultsGetBloc;

  ResultSaveBloc(this._localDatabaseService, this._resultsGetBloc);

  @override
  Future<void> saveToDatabase(ResultSaveBlocArgs args) async {
    var resultId = await _localDatabaseService.insertQuery(
        AlgorithmResult.saveToDatabase(args.result.algorithmResult));
    await _localDatabaseService.insertQueries(
      BestInEpoch.saveMultiToDatabase(args.result.bestInEpochs(resultId)),
    );
    await _localDatabaseService.insertQueries(
      AverageInEpoch.saveMultiToDatabase(args.result.averageInEpochs(resultId)),
    );
    await _localDatabaseService.insertQueries(
      StandardDeviation.saveMultiToDatabase(
          args.result.standardDeviations(resultId)),
    );

    args.params.resultId = resultId;
    await _localDatabaseService.insertQuery(
      AlgorithmParams.saveToDatabase(args.params),
    );

    _resultsGetBloc.add(LocalDatabaseGetRefreshEvent());
  }
}
