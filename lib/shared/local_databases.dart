import 'package:genetic_algorithms/data/models/local_database/database.dart';
import 'package:genetic_algorithms/data/models/local_database/database_column.dart';
import 'package:genetic_algorithms/data/models/local_database/database_table.dart';

DbModel database1 = DbModel(
  name: "db2",
  version: 2,
  tables: [
    DbTable(
      name: "RESULT",
      columns: [
        DbColumn(name: "NAME", columnType: DbColumnType.STRING),
      ],
    )
  ],
);
