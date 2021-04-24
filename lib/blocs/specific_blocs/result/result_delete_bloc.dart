import 'dart:async';

import 'package:genetic_algorithms/blocs/abstract/local_database_delete/local_database_delete_bloc.dart';
import 'package:genetic_algorithms/data/local_database/database_actions.dart';
import 'package:genetic_algorithms/data/models/algorithm_params.dart';
import 'package:genetic_algorithms/data/models/algorithm_result.dart';
import 'package:genetic_algorithms/data/models/average_in_epoch.dart';
import 'package:genetic_algorithms/data/models/best_in_epoch.dart';
import 'package:genetic_algorithms/data/models/standard_deviation.dart';
import 'package:genetic_algorithms/data/services/local_database_service.dart';
import 'package:genetic_algorithms/shared/exceptions.dart';

class ResultDeleteBloc extends LocalDatabaseDeleteBloc<AlgorithmResult> {
  LocalDatabaseService _localDatabaseService;

  ResultDeleteBloc(this._localDatabaseService);

  @override
  Future<void> deleteFromDatabase(AlgorithmResult algorithmResult) async {
    if (algorithmResult.resultId != null) {
      await _localDatabaseService.batch([
        DatabaseDeleteAction(
          tableName: AlgorithmResult.dbTable.name,
          columnName: AlgorithmResult.dbResultId.name,
          columnValue: algorithmResult.resultId,
        ),
        DatabaseDeleteAction(
          tableName: AlgorithmParams.dbTable.name,
          columnName: AlgorithmParams.dbResultId.name,
          columnValue: algorithmResult.resultId,
        ),
        DatabaseDeleteAction(
          tableName: BestInEpoch.dbTable.name,
          columnName: BestInEpoch.dbResultId.name,
          columnValue: algorithmResult.resultId,
        ),
        DatabaseDeleteAction(
          tableName: AverageInEpoch.dbTable.name,
          columnName: AverageInEpoch.dbResultId.name,
          columnValue: algorithmResult.resultId,
        ),
        DatabaseDeleteAction(
          tableName: StandardDeviation.dbTable.name,
          columnName: StandardDeviation.dbResultId.name,
          columnValue: algorithmResult.resultId,
        )
      ]);
    } else {
      throw LocalDatabaseFailureException(LocalDatabaseError.DELETE_ERROR, "");
    }
  }
}
