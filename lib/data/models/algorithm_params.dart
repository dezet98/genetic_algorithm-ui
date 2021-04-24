import 'package:genetic_algorithms/data/local_database/database_actions.dart';
import 'package:genetic_algorithms/data/local_database/database_column.dart';
import 'package:genetic_algorithms/data/local_database/database_model.dart';
import 'package:genetic_algorithms/data/local_database/database_table.dart';
import 'package:genetic_algorithms/shared/exceptions.dart';

class AlgorithmParams extends DatabaseModel {
  int? resultId;
  final double startRange;
  final double endRange;
  final int populationAmount;
  final int epochsAmount;
  final double selectionProbability;
  final double crossProbability;
  final double mutationProbability;
  final int eliteStrategyAmount;
  final bool gradeStrategy;
  final String selection;
  final String cross;
  final String mutation;

  AlgorithmParams({
    this.resultId,
    required this.startRange,
    required this.endRange,
    required this.populationAmount,
    required this.epochsAmount,
    required this.selectionProbability,
    required this.crossProbability,
    required this.mutationProbability,
    required this.eliteStrategyAmount,
    required this.gradeStrategy,
    required this.selection,
    required this.cross,
    required this.mutation,
  });

  static DbTable dbTable = DbTable(name: "PARAMS", columns: _dbColumns);

  static List<DbColumn> _dbColumns = [
    dbResultId,
    dbStartRange,
    dbEndRange,
    dbPopulationAmount,
    dbEpochsAmount,
    dbSelectionProbability,
    dbCrossProbability,
    dbMutationProbability,
    dbEliteStrategyAmount,
    dbGradeStrategy,
    dbSelection,
    dbCross,
    dbMutation,
  ];

  // dbColumns
  static DbColumn dbResultId =
      DbColumn(name: "RESULT_ID", columnType: DbColumnType.INT);
  static DbColumn dbStartRange =
      DbColumn(name: "START_RANGE", columnType: DbColumnType.DOUBLE);
  static DbColumn dbEndRange =
      DbColumn(name: "END_RANGE", columnType: DbColumnType.DOUBLE);
  static DbColumn dbPopulationAmount =
      DbColumn(name: "POPULATION_AMOUNT", columnType: DbColumnType.INT);
  static DbColumn dbEpochsAmount =
      DbColumn(name: "EPOCHS_AMOUNT", columnType: DbColumnType.INT);
  static DbColumn dbSelectionProbability =
      DbColumn(name: "SELECTION_PROBABILITY", columnType: DbColumnType.DOUBLE);
  static DbColumn dbCrossProbability =
      DbColumn(name: "CROSS_PROBABILITY", columnType: DbColumnType.DOUBLE);
  static DbColumn dbMutationProbability =
      DbColumn(name: "MUTATION_PROBABILITY", columnType: DbColumnType.DOUBLE);
  static DbColumn dbEliteStrategyAmount =
      DbColumn(name: "ELITE_STRATEGY_AMOUNT", columnType: DbColumnType.INT);
  static DbColumn dbGradeStrategy =
      DbColumn(name: "GRADE_STRATEGY", columnType: DbColumnType.INT);
  static DbColumn dbSelection =
      DbColumn(name: "SELECTION", columnType: DbColumnType.STRING);
  static DbColumn dbCross =
      DbColumn(name: "CROSS", columnType: DbColumnType.STRING);
  static DbColumn dbMutation =
      DbColumn(name: "MUTATION", columnType: DbColumnType.STRING);

  static DatabaseInsertAction saveToDatabase(AlgorithmParams algorithmParams) {
    return DatabaseInsertAction(tableName: dbTable.name, map: {
      dbResultId.name: algorithmParams.resultId,
      dbStartRange.name: algorithmParams.startRange,
      dbEndRange.name: algorithmParams.endRange,
      dbPopulationAmount.name: algorithmParams.populationAmount,
      dbEpochsAmount.name: algorithmParams.epochsAmount,
      dbSelectionProbability.name: algorithmParams.selectionProbability,
      dbCrossProbability.name: algorithmParams.crossProbability,
      dbMutationProbability.name: algorithmParams.mutationProbability,
      dbEliteStrategyAmount.name: algorithmParams.eliteStrategyAmount,
      dbGradeStrategy.name: algorithmParams.gradeStrategy ? 1 : 0,
      dbSelection.name: algorithmParams.selection,
      dbCross.name: algorithmParams.cross,
      dbMutation.name: algorithmParams.mutation,
    });
  }

  static AlgorithmParams fromDataBase(Map<String, Object?> map) {
    try {
      var cross = map[dbCross.name] as String;
      var crossProbability = map[dbCrossProbability.name] as double;
      var eliteStrategyAmount = map[dbEliteStrategyAmount.name] as int;
      var endRange = map[dbEndRange.name] as double;
      var epochsAmount = map[dbEpochsAmount.name] as int;
      var gradeStrategy =
          (map[dbGradeStrategy.name] as int) == 1 ? true : false;
      var mutation = map[dbMutation.name] as String;
      var mutationProbability = map[dbMutationProbability.name] as double;
      var populationAmount = map[dbPopulationAmount.name] as int;
      var selection = map[dbSelection.name] as String;
      var selectionProbability = map[dbSelectionProbability.name] as double;
      var startRange = map[dbStartRange.name] as double;
      var resultId = map[dbResultId.name] as int;

      return AlgorithmParams(
        cross: cross,
        crossProbability: crossProbability,
        eliteStrategyAmount: eliteStrategyAmount,
        endRange: endRange,
        epochsAmount: epochsAmount,
        gradeStrategy: gradeStrategy,
        mutation: mutation,
        mutationProbability: mutationProbability,
        populationAmount: populationAmount,
        selection: selection,
        selectionProbability: selectionProbability,
        startRange: startRange,
        resultId: resultId,
      );
    } catch (e) {
      throw LocalDatabaseFailureException(
          LocalDatabaseError.GET_FROM_DATABASE_CAST_ERROR, e.toString());
    }
  }
}
