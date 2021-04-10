import 'package:genetic_algorithms/data/algorithm/result.dart';
import 'package:genetic_algorithms/data/models/local_database/database.dart';

DbModel database1 = DbModel(
  name: "db6",
  version: 2,
  tables: [...Result.getDbTables()],
);
