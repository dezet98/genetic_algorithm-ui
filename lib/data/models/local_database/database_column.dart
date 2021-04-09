class DbColumn {
  final String name;
  final DbColumnType columnType;
  final isPrimaryKey;

  DbColumn(
      {required this.name,
      required this.columnType,
      this.isPrimaryKey = false});

  String get type {
    switch (columnType) {
      case DbColumnType.STRING:
        return "STRING";
      case DbColumnType.INT:
        return "INTEGER";
      case DbColumnType.TEXT:
        return "TEXT";
    }
  }
}

enum DbColumnType { STRING, INT, TEXT }
