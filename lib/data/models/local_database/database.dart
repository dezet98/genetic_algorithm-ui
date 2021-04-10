import 'database_table.dart';

class DbModel {
  final List<DbTable> tables;
  final String name;
  final int version;

  DbModel({required this.tables, required this.name, required this.version});

  List<String> createTableQueries() {
    List<String> queries = [];
    for (DbTable dbTable in tables) {
      queries.add(createTable(dbTable));
    }

    return queries;
  }

  static String createTable(DbTable dbTable) {
    String query = "CREATE TABLE ${dbTable.name}(";

    var columnsLength = dbTable.columns.length;
    for (var i = 0; i < columnsLength; i++) {
      query += "${dbTable.columns[i].name} ${dbTable.columns[i].type}";

      if (dbTable.columns[i].isPrimaryKey)
        query += " " + DbTable.typeToString(DbType.PRIMARY_KEY) + " ";

      query += (i == columnsLength - 1) ? '' : ', ';
    }

    query += ")";
    return query;
  }
}
