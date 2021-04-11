import 'dart:async';

import 'package:genetic_algorithms/blocs/abstract/local_database_get/local_database_get_bloc.dart';
import 'package:genetic_algorithms/data/local_database/database_actions.dart';
import 'package:genetic_algorithms/data/models/average_in_epoch.dart';
import 'package:genetic_algorithms/data/models/best_in_epoch.dart';
import 'package:genetic_algorithms/data/models/standard_deviation.dart';
import 'package:genetic_algorithms/data/services/local_database_service.dart';

class ResultDetailsGetBlocData {
  final List<BestInEpoch>? bestInEpochs;
  final List<AverageInEpoch>? averageInEpochs;
  final List<StandardDeviation>? standardDeviations;

  ResultDetailsGetBlocData({
    required this.bestInEpochs,
    required this.averageInEpochs,
    required this.standardDeviations,
  });
}

class ResultDetailsGetBloc
    extends LocalDatabaseGetBloc<ResultDetailsGetBlocData> {
  LocalDatabaseService _localDatabaseService;
  int rewardId;

  ResultDetailsGetBloc(this._localDatabaseService, this.rewardId);

  @override
  Future<ResultDetailsGetBlocData> getFromDatabase() async {
    final List<BestInEpoch>? bestInEpochs = await queryBestInEpochs();

    final List<AverageInEpoch>? averageInEpochs = await queryAverageInEpochs();

    final List<StandardDeviation>? standardDeviations =
        await queryStandardDeviations();

    return ResultDetailsGetBlocData(
      bestInEpochs: bestInEpochs,
      averageInEpochs: averageInEpochs,
      standardDeviations: standardDeviations,
    );
  }

  Future<List<BestInEpoch>?> queryBestInEpochs() async {
    List<Map<String, Object?>>? bestInEpochsQueries =
        await _localDatabaseService.query(
      DatabaseQueryAction(
        tableName: BestInEpoch.dbTable.name,
        columnName: BestInEpoch.dbResultId.name,
        columnValue: rewardId,
      ),
    );

    return List.generate(bestInEpochsQueries.length,
        (index) => BestInEpoch.fromDataBase(bestInEpochsQueries[index]));
  }

  Future<List<AverageInEpoch>?> queryAverageInEpochs() async {
    List<Map<String, Object?>>? averageInEpochsQueries =
        await _localDatabaseService.query(DatabaseQueryAction(
      tableName: AverageInEpoch.dbTable.name,
      columnName: AverageInEpoch.dbResultId.name,
      columnValue: rewardId,
    ));

    return List.generate(averageInEpochsQueries.length,
        (index) => AverageInEpoch.fromDataBase(averageInEpochsQueries[index]));
  }

  Future<List<StandardDeviation>?> queryStandardDeviations() async {
    List<Map<String, Object?>>? standardDeviationsQueries =
        await _localDatabaseService.query(DatabaseQueryAction(
      tableName: StandardDeviation.dbTable.name,
      columnName: StandardDeviation.dbResultId.name,
      columnValue: rewardId,
    ));

    return List.generate(
        standardDeviationsQueries.length,
        (index) =>
            StandardDeviation.fromDataBase(standardDeviationsQueries[index]));
  }
}
