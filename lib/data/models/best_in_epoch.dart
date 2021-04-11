import 'package:genetic_algorithms/data/local_database/database_actions.dart';
import 'package:genetic_algorithms/data/local_database/database_column.dart';
import 'package:genetic_algorithms/data/local_database/database_model.dart';
import 'package:genetic_algorithms/data/local_database/database_table.dart';

class BestInEpoch extends DatabaseModel {
  int? resultId;
  int epoch;
  double value;

  BestInEpoch({this.resultId, required this.epoch, required this.value});

  static DbTable dbTable = DbTable(name: "BEST_IN_EPOCH", columns: _dbColumns);

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

  static DatabaseInsertAction saveToDatabase(BestInEpoch bestInEpoch) {
    return DatabaseInsertAction(
      tableName: dbTable.name,
      map: {
        dbResultId.name: bestInEpoch.resultId,
        dbEpoch.name: bestInEpoch.epoch,
        dbValue.name: bestInEpoch.value,
      },
    );
  }

  static List<DatabaseInsertAction> saveMultiToDatabase(
      List<BestInEpoch> bestInEpochs) {
    return List.generate(
      bestInEpochs.length,
      (index) => DatabaseInsertAction(
        tableName: dbTable.name,
        map: {
          dbResultId.name: bestInEpochs[index].resultId,
          dbEpoch.name: bestInEpochs[index].epoch,
          dbValue.name: bestInEpochs[index].value,
        },
      ),
    );
  }

  static BestInEpoch fromDataBase(Map<String, Object?> map) {
    var resultId = map[dbResultId.name] as int;
    var epoch = map[dbEpoch.name] as int;
    var value = map[dbValue.name] as double;

    return BestInEpoch(resultId: resultId, epoch: epoch, value: value);
  }
}
