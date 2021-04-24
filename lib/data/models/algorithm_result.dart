import 'package:genetic_algorithms/data/local_database/database_actions.dart';
import 'package:genetic_algorithms/data/local_database/database_column.dart';
import 'package:genetic_algorithms/data/local_database/database_model.dart';
import 'package:genetic_algorithms/data/local_database/database_table.dart';
import 'package:genetic_algorithms/shared/exceptions.dart';

import 'algorithm_params.dart';

class AlgorithmResult extends DatabaseModel {
  int? resultId;
  String algorithmTime;
  double best;
  DateTime creationTime;
  double bestAverage;

  // local
  AlgorithmParams? algorithmParams;

  AlgorithmResult(
      {required this.algorithmTime,
      required this.best,
      required this.creationTime,
      required this.bestAverage,
      this.resultId});

  static DbTable dbTable = DbTable(name: "RESULT", columns: _dbColumns);

  static List<DbColumn> _dbColumns = [
    dbResultId,
    dbAlgorithmTime,
    dbBest,
    dbBestAverage,
    dbCreationTime,
  ];

  // dbColumns
  static DbColumn dbResultId = DbColumn(
      name: "RESULT_ID", columnType: DbColumnType.INT, isPrimaryKey: true);
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
      dbAlgorithmTime.name: algorithmResult.algorithmTime,
      dbBest.name: algorithmResult.best,
      dbBestAverage.name: algorithmResult.bestAverage,
      dbCreationTime.name: algorithmResult.creationTime.toIso8601String(),
    });
  }

  static AlgorithmResult fromDataBase(Map<String, Object?> map) {
    try {
      var resultId = map[dbResultId.name] as int;
      var algorithmTime = (map[dbAlgorithmTime.name] as double).toString();
      var best = map[dbBest.name] as double;
      var bestAverage = map[dbBestAverage.name] as double;
      var creationTime = map[dbCreationTime.name] as String;

      return AlgorithmResult(
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
