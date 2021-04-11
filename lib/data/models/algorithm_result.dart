import 'package:genetic_algorithms/data/local_database/database_actions.dart';
import 'package:genetic_algorithms/data/local_database/database_column.dart';
import 'package:genetic_algorithms/data/local_database/database_model.dart';
import 'package:genetic_algorithms/data/local_database/database_table.dart';
import 'package:genetic_algorithms/shared/exceptions.dart';

class AlgorithmResult extends DatabaseModel {
  int? resultId;
  int epochsAmount;
  int populationSize;
  String algorithmTime;
  double best;
  DateTime creationTime;
  double bestAverage;

  AlgorithmResult(
      {required this.epochsAmount,
      required this.populationSize,
      required this.algorithmTime,
      required this.best,
      required this.creationTime,
      required this.bestAverage,
      this.resultId});

  static DbTable dbTable = DbTable(name: "RESULT", columns: _dbColumns);

  static List<DbColumn> _dbColumns = [
    dbResultId,
    dbEpochsAmount,
    dbPopulationSize,
    dbAlgorithmTime,
    dbBest,
    dbBestAverage,
    dbCreationTime,
  ];

  // dbColumns
  static DbColumn dbResultId = DbColumn(
      name: "RESULT_ID", columnType: DbColumnType.INT, isPrimaryKey: true);
  static DbColumn dbEpochsAmount =
      DbColumn(name: "EPOCHS_AMOUNT", columnType: DbColumnType.INT);
  static DbColumn dbPopulationSize =
      DbColumn(name: "POPULATION_SIZE", columnType: DbColumnType.INT);
  static DbColumn dbAlgorithmTime =
      DbColumn(name: "ALGORITHM_TIME", columnType: DbColumnType.STRING);
  static DbColumn dbBest =
      DbColumn(name: "BEST", columnType: DbColumnType.DOUBLE);
  static DbColumn dbBestAverage =
      DbColumn(name: "BEST_AVERAGE", columnType: DbColumnType.DOUBLE);
  static DbColumn dbCreationTime =
      DbColumn(name: "CREATION_TIME", columnType: DbColumnType.STRING);

  static DatabaseInsertAction saveToDatabase(AlgorithmResult algorithmResult) {
    return DatabaseInsertAction(tableName: dbTable.name, map: {
      dbEpochsAmount.name: algorithmResult.epochsAmount,
      dbPopulationSize.name: algorithmResult.populationSize,
      dbAlgorithmTime.name: algorithmResult.algorithmTime,
      dbBest.name: algorithmResult.best,
      dbBestAverage.name: algorithmResult.bestAverage,
      dbCreationTime.name: algorithmResult.creationTime.toIso8601String(),
    });
  }

  static AlgorithmResult fromDataBase(Map<String, Object?> map) {
    try {
      var resultId = map[dbResultId.name] as int;
      var epochsAmount = map[dbEpochsAmount.name] as int;
      var populationSize = map[dbPopulationSize.name] as int;
      var algorithmTime = (map[dbAlgorithmTime.name] as double).toString();
      var best = map[dbBest.name] as double;
      var bestAverage = map[dbBestAverage.name] as double;
      var creationTime = map[dbCreationTime.name] as String;

      return AlgorithmResult(
          epochsAmount: epochsAmount,
          populationSize: populationSize,
          algorithmTime: algorithmTime,
          best: best,
          bestAverage: bestAverage,
          creationTime: DateTime.parse(creationTime),
          resultId: resultId);
    } catch (e) {
      throw LocalDatabaseFailureException(
          LocalDatabaseError.GET_FROM_DATABASE_CAST_ERROR, e.toString());
    }
  }
}
