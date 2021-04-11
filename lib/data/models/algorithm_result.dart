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

  AlgorithmResult(
      {required this.epochsAmount,
      required this.populationSize,
      required this.algorithmTime,
      this.resultId});

  static DbTable dbTable = DbTable(name: "RESULT", columns: _dbColumns);

  static List<DbColumn> _dbColumns = [
    dbResultId,
    dbEpochsAmount,
    dbPopulationSize,
    dbAlgorithmTime
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

  static DatabaseInsertAction saveToDatabase(AlgorithmResult algorithmResult) {
    return DatabaseInsertAction(tableName: dbTable.name, map: {
      dbEpochsAmount.name: algorithmResult.epochsAmount,
      dbPopulationSize.name: algorithmResult.populationSize,
      dbAlgorithmTime.name: algorithmResult.algorithmTime
    });
  }

  static AlgorithmResult fromDataBase(Map<String, Object?> map) {
    try {
      var resultId = map[dbResultId.name] as int;
      var epochsAmount = map[dbEpochsAmount.name] as int;
      var populationSize = map[dbPopulationSize.name] as int;
      var algorithmTime = (map[dbAlgorithmTime.name] as double).toString();

      return AlgorithmResult(
          epochsAmount: epochsAmount,
          populationSize: populationSize,
          algorithmTime: algorithmTime,
          resultId: resultId);
    } catch (e) {
      throw LocalDatabaseFailureException(
          LocalDatabaseError.GET_FROM_DATABASE_CAST_ERROR, e.toString());
    }
  }
}
