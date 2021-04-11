enum DatabaseQueryTypes { insert, delete, query }

abstract class DatabaseAction {
  DatabaseQueryTypes get type;
}

class DatabaseInsertAction extends DatabaseAction {
  String tableName;
  Map<String, Object?> map;
  DatabaseQueryTypes type = DatabaseQueryTypes.insert;

  DatabaseInsertAction({required this.tableName, required this.map});
}

class DatabaseDeleteAction extends DatabaseAction {
  String tableName;
  String? columnName;
  dynamic? columnValue;
  DatabaseQueryTypes type = DatabaseQueryTypes.delete;

  DatabaseDeleteAction(
      {required this.tableName, this.columnName, this.columnValue});
}

class DatabaseQueryAction extends DatabaseAction {
  String tableName;
  String? columnName;
  dynamic? columnValue;
  DatabaseQueryTypes type = DatabaseQueryTypes.delete;

  DatabaseQueryAction(
      {required this.tableName, this.columnName, this.columnValue});
}
