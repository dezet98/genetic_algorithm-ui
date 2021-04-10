import 'package:genetic_algorithms/data/local_database/database_column.dart';
import 'package:genetic_algorithms/data/local_database/database_insert.dart';
import 'package:genetic_algorithms/data/local_database/database_model.dart';
import 'package:genetic_algorithms/data/local_database/database_table.dart';

class AverageInEpoch extends DatabaseModel {
  int? resultId;
  int epoch;
  double value;

  AverageInEpoch({this.resultId, required this.epoch, required this.value});

  static DbTable dbTable =
      DbTable(name: "AVERAGE_IN_EPOCH", columns: _dbColumns);

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

  static DatabaseInsertQuery saveToDatabase(AverageInEpoch averageInEpoch) {
    return DatabaseInsertQuery(dbTable.name, {
      dbResultId.name: averageInEpoch.resultId,
      dbEpoch.name: averageInEpoch.epoch,
      dbValue.name: averageInEpoch.value,
    });
  }

  static List<DatabaseInsertQuery> saveMultiToDatabase(
      List<AverageInEpoch> averageInEpochs) {
    return List.generate(
      averageInEpochs.length,
      (index) => DatabaseInsertQuery(
        dbTable.name,
        {
          dbResultId.name: averageInEpochs[index].resultId,
          dbEpoch.name: averageInEpochs[index].epoch,
          dbValue.name: averageInEpochs[index].value,
        },
      ),
    );
  }

  static AverageInEpoch fromDataBase(Map<String, Object?> map) {
    var resultId = map[dbResultId.name] as int;
    var epoch = map[dbEpoch.name] as int;
    var value = map[dbValue.name] as double;

    return AverageInEpoch(resultId: resultId, epoch: epoch, value: value);
  }
}
