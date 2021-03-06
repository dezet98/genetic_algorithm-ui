import 'package:genetic_algorithms/data/local_database/database_actions.dart';
import 'package:genetic_algorithms/data/local_database/database_column.dart';
import 'package:genetic_algorithms/data/local_database/database_model.dart';
import 'package:genetic_algorithms/data/local_database/database_table.dart';

class StandardDeviation extends DatabaseModel {
  int? resultId;
  int epoch;
  double value;

  StandardDeviation({this.resultId, required this.epoch, required this.value});

  static DbTable dbTable =
      DbTable(name: "STANDARD_DEVIATION", columns: _dbColumns);

  static List<DbColumn> _dbColumns = [
    dbResultId,
    dbEpoch,
    dbValue,
  ];

  // dbColumns
  static DbColumn dbResultId =
      DbColumn(name: "RESULT_ID", columnType: DbColumnType.INT);
  static DbColumn dbEpoch =
      DbColumn(name: "EPOCH", columnType: DbColumnType.INT);
  static DbColumn dbValue =
      DbColumn(name: "VALUE", columnType: DbColumnType.DOUBLE);

  static DatabaseInsertAction saveToDatabase(
      StandardDeviation standardDeviation) {
    return DatabaseInsertAction(tableName: dbTable.name, map: {
      dbResultId.name: standardDeviation.resultId,
      dbEpoch.name: standardDeviation.epoch,
      dbValue.name: standardDeviation.value,
    });
  }

  static List<DatabaseInsertAction> saveMultiToDatabase(
      List<StandardDeviation> standardDeviations) {
    return List.generate(
      standardDeviations.length,
      (index) => DatabaseInsertAction(
        tableName: dbTable.name,
        map: {
          dbResultId.name: standardDeviations[index].resultId,
          dbEpoch.name: standardDeviations[index].epoch,
          dbValue.name: standardDeviations[index].value,
        },
      ),
    );
  }

  static StandardDeviation fromDataBase(Map<String, Object?> map) {
    var resultId = map[dbResultId.name] as int;
    var epoch = map[dbEpoch.name] as int;
    var value = map[dbValue.name] as double;

    return StandardDeviation(resultId: resultId, epoch: epoch, value: value);
  }
}
