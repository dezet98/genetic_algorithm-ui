import 'dart:async';

import 'package:genetic_algorithms/blocs/abstract/local_database_delete/local_database_delete_bloc.dart';
import 'package:genetic_algorithms/data/models/algorithm_result.dart';
import 'package:genetic_algorithms/data/services/local_database_service.dart';
import 'package:genetic_algorithms/shared/exceptions.dart';

class ResultDeleteBloc extends LocalDatabaseDeleteBloc<AlgorithmResult> {
  LocalDatabaseService _localDatabaseService;

  ResultDeleteBloc(this._localDatabaseService);

  @override
  Future<void> deleteFromDatabase(AlgorithmResult algorithmResult) async {
    if (algorithmResult.resultId != null) {
      await _localDatabaseService.delete(AlgorithmResult.dbTable.name,
          AlgorithmResult.dbResultId.name, algorithmResult.resultId);
    } else {
      throw LocalDatabaseFailureException(LocalDatabaseError.DELETE_ERROR, "");
    }
  }
}
