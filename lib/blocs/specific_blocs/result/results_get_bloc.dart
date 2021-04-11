import 'dart:async';

import 'package:genetic_algorithms/blocs/abstract/local_database_get/local_database_get_bloc.dart';
import 'package:genetic_algorithms/data/local_database/database_actions.dart';
import 'package:genetic_algorithms/data/models/algorithm_result.dart';
import 'package:genetic_algorithms/data/services/local_database_service.dart';

class ResultsGetBloc extends LocalDatabaseGetBloc<List<AlgorithmResult>> {
  LocalDatabaseService _localDatabaseService;

  ResultsGetBloc(this._localDatabaseService);

  @override
  Future<List<AlgorithmResult>> getFromDatabase() async {
    List<Map<String, Object?>>? queries = await _localDatabaseService
        .query(DatabaseQueryAction(tableName: AlgorithmResult.dbTable.name));

    return List.generate(queries.length,
        (index) => AlgorithmResult.fromDataBase(queries[index]));
  }
}
