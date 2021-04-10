import 'database_table.dart';

abstract class DatabaseModel {
  List<DbTable> get getDbTables;
}
