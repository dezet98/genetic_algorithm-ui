import 'database_column.dart';

class DbTable {
  final String name;
  final List<DbColumn> columns;

  DbTable({required this.name, required this.columns});

  static String typeToString(DbType type) {
    switch (type) {
      case DbType.PRIMARY_KEY:
        return "PRIMARY_KEY";
    }
  }

  // Map<String, Object?> getMap() {
  //   Map<String, Object?> map = {};
  //   for (var column in columns) {
  //     map[column.name] = column.
  //   }
  // }
}

enum DbType { PRIMARY_KEY }
