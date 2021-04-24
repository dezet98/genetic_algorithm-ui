import 'package:genetic_algorithms/data/local_database/database.dart';
import 'package:genetic_algorithms/data/models/algorithm_params.dart';
import 'package:genetic_algorithms/data/models/algorithm_result.dart';
import 'package:genetic_algorithms/data/models/average_in_epoch.dart';
import 'package:genetic_algorithms/data/models/best_in_epoch.dart';
import 'package:genetic_algorithms/data/models/standard_deviation.dart';

DbModel database1 = DbModel(
  name: "db20",
  version: 2,
  tables: [
    AlgorithmResult.dbTable,
    AverageInEpoch.dbTable,
    BestInEpoch.dbTable,
    StandardDeviation.dbTable,
    AlgorithmParams.dbTable
  ],
);
