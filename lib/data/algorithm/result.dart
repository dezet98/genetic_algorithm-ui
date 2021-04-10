import 'package:genetic_algorithms/data/models/local_database/database_column.dart';
import 'package:genetic_algorithms/data/models/local_database/database_insert.dart';
import 'package:genetic_algorithms/data/models/local_database/database_table.dart';

class Result {
  late int epochsAmount;
  late int populationSize;
  late String algorithmTime;
  late List<double> bestInEpoch = [];
  late List<double> averageInEpoch = [];
  late List<double> standardDeviation = [];

  Result(
      {required this.epochsAmount,
      required this.populationSize,
      required this.algorithmTime,
      required this.bestInEpoch,
      required this.averageInEpoch,
      required this.standardDeviation});

  Result.fromDataBase(List<Map<String, Object?>> map) {
    epochsAmount = 0;
    populationSize = 0;
    algorithmTime = "";
    bestInEpoch = [];
    averageInEpoch = [];
    standardDeviation = [];
  }

  DatabaseInsertQuery resultTableInsert() {
    return DatabaseInsertQuery(RESULT_DB_TABLE, {
      RESULT_DB_TABLE_EPOCHS_AMOUNT_DB_COLUMN: epochsAmount,
      RESULT_DB_TABLE_POPULATION_SIZE_DB_COLUMN: populationSize,
      RESULT_DB_TABLE_ALGORITH_TIME_DB_COLUMN: algorithmTime
    });
  }

  List<DatabaseInsertQuery> bestEpochInsert(int resultId) {
    return [
      for (var i = 0; i < bestInEpoch.length; i++)
        DatabaseInsertQuery(BEST_IN_EPOCH_DB_TABLE, {
          BEST_IN_EPOCH_DB_TABLE_RESULT_ID_DB_COLUMN: resultId,
          BEST_IN_EPOCH_DB_TABLE_EPOCH_DB_COLUMN: i,
          BEST_IN_EPOCH_DB_TABLE_VALUE_DB_COLUMN: bestInEpoch[i],
        })
    ];
  }

  List<DatabaseInsertQuery> averageInEpochInsert(int resultId) {
    return [
      for (var i = 0; i < averageInEpoch.length; i++)
        DatabaseInsertQuery(AVERAGE_IN_EPOCH_DB_TABLE, {
          AVERAGE_IN_EPOCH_DB_TABLE_RESULT_ID_DB_COLUMN: resultId,
          AVERAGE_IN_EPOCH_DB_TABLE_EPOCH_DB_COLUMN: i,
          AVERAGE_IN_EPOCH_DB_TABLE_VALUE_DB_COLUMN: averageInEpoch[i],
        }),
    ];
  }

  List<DatabaseInsertQuery> standardDeviationInsert(int resultId) {
    return [
      for (var i = 0; i < standardDeviation.length; i++)
        DatabaseInsertQuery(STANDARD_DEVIATION_DB_TABLE, {
          STANDARD_DEVIATION_DB_TABLE_RESULT_ID_DB_COLUMN: resultId,
          STANDARD_DEVIATION_DB_TABLE_EPOCH_DB_COLUMN: i,
          STANDARD_DEVIATION_DB_TABLE_VALUE_DB_COLUMN: standardDeviation[i],
        }),
    ];
  }

  static List<DbTable> getDbTables() {
    return [
      DbTable(
        name: RESULT_DB_TABLE,
        columns: [
          DbColumn(
              name: RESULT_DB_RESULT_ID_COLUMN,
              columnType: DbColumnType.INT,
              isPrimaryKey: true),
          DbColumn(
              name: RESULT_DB_TABLE_EPOCHS_AMOUNT_DB_COLUMN,
              columnType: DbColumnType.INT),
          DbColumn(
              name: RESULT_DB_TABLE_POPULATION_SIZE_DB_COLUMN,
              columnType: DbColumnType.INT),
          DbColumn(
              name: RESULT_DB_TABLE_ALGORITH_TIME_DB_COLUMN,
              columnType: DbColumnType.STRING),
        ],
      ),
      DbTable(name: BEST_IN_EPOCH_DB_TABLE, columns: [
        DbColumn(
            name: BEST_IN_EPOCH_DB_TABLE_RESULT_ID_DB_COLUMN,
            columnType: DbColumnType.INT),
        DbColumn(
            name: BEST_IN_EPOCH_DB_TABLE_EPOCH_DB_COLUMN,
            columnType: DbColumnType.INT),
        DbColumn(
            name: BEST_IN_EPOCH_DB_TABLE_VALUE_DB_COLUMN,
            columnType: DbColumnType.DOUBLE),
      ]),
      DbTable(name: AVERAGE_IN_EPOCH_DB_TABLE, columns: [
        DbColumn(
            name: AVERAGE_IN_EPOCH_DB_TABLE_RESULT_ID_DB_COLUMN,
            columnType: DbColumnType.INT),
        DbColumn(
            name: AVERAGE_IN_EPOCH_DB_TABLE_EPOCH_DB_COLUMN,
            columnType: DbColumnType.INT),
        DbColumn(
            name: AVERAGE_IN_EPOCH_DB_TABLE_VALUE_DB_COLUMN,
            columnType: DbColumnType.DOUBLE),
      ]),
      DbTable(name: STANDARD_DEVIATION_DB_TABLE, columns: [
        DbColumn(
            name: STANDARD_DEVIATION_DB_TABLE_RESULT_ID_DB_COLUMN,
            columnType: DbColumnType.INT),
        DbColumn(
            name: STANDARD_DEVIATION_DB_TABLE_EPOCH_DB_COLUMN,
            columnType: DbColumnType.INT),
        DbColumn(
            name: STANDARD_DEVIATION_DB_TABLE_VALUE_DB_COLUMN,
            columnType: DbColumnType.DOUBLE),
      ]),
    ];
  }

  static const String RESULT_DB_TABLE = "RESULT";
  static const String RESULT_DB_RESULT_ID_COLUMN = "REWARD_ID";
  static const String RESULT_DB_TABLE_EPOCHS_AMOUNT_DB_COLUMN = "EPOCHS_AMOUNT";
  static const String RESULT_DB_TABLE_POPULATION_SIZE_DB_COLUMN =
      "POPULATION_SIZE";
  static const String RESULT_DB_TABLE_ALGORITH_TIME_DB_COLUMN = "ALGORITH_TIME";

  static const String BEST_IN_EPOCH_DB_TABLE = "BEST_IN_EPOCH";
  static const String BEST_IN_EPOCH_DB_TABLE_RESULT_ID_DB_COLUMN = "RESULT_ID";
  static const String BEST_IN_EPOCH_DB_TABLE_EPOCH_DB_COLUMN = "EPOCH";
  static const String BEST_IN_EPOCH_DB_TABLE_VALUE_DB_COLUMN = "VALUE";

  static const String AVERAGE_IN_EPOCH_DB_TABLE = "AVERAGE_IN_EPOCH";
  static const String AVERAGE_IN_EPOCH_DB_TABLE_RESULT_ID_DB_COLUMN =
      "RESULT_ID";
  static const String AVERAGE_IN_EPOCH_DB_TABLE_EPOCH_DB_COLUMN = "EPOCH";
  static const String AVERAGE_IN_EPOCH_DB_TABLE_VALUE_DB_COLUMN = "VALUE";

  static const String STANDARD_DEVIATION_DB_TABLE = "STANDARD_DEVIATION";
  static const String STANDARD_DEVIATION_DB_TABLE_RESULT_ID_DB_COLUMN =
      "RESULT_ID";
  static const String STANDARD_DEVIATION_DB_TABLE_EPOCH_DB_COLUMN = "EPOCH";
  static const String STANDARD_DEVIATION_DB_TABLE_VALUE_DB_COLUMN = "VALUE";
}
