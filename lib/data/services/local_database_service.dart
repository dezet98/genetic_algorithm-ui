import 'package:genetic_algorithms/data/local_database/database.dart';
import 'package:genetic_algorithms/data/local_database/database_insert.dart';
import 'package:genetic_algorithms/shared/platforms.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class LocalDatabaseService {
  final DbModel _dbModel;
  Database? _database;

  LocalDatabaseService(this._dbModel);

  Future<String?> _databasePath() async {
    if (PlatformInfo.isDesktop) {
      sqfliteFfiInit();
      return join((await databaseFactoryFfi.getDatabasesPath()), _dbModel.name);
    } else if (PlatformInfo.isMobile) {
      return join(
          ((await getApplicationDocumentsDirectory()).path), _dbModel.name);
    }
    return Future.value(null);
  }

  Future<void> openDatabase() async {
    var path = await _databasePath();
    if (path != null) {
      _database = await databaseFactoryFfi.openDatabase(path,
          options: OpenDatabaseOptions(
              onCreate: _onCreate, version: _dbModel.version));
    } else {
      // EXCEPTION
      throw Exception();
    }
  }

  Future<void> closeDatabase() async {
    if (_database!.isOpen) {
      await _database!.close();
    }
  }

  void _onCreate(Database db, int version) async {
    for (String query in _dbModel.createTableQueries()) {
      await db.execute(query);
    }
  }

  Future<int> insertQuery(DatabaseInsertQuery insertQuery) async {
    await checkIfOpen();
    return await _database!.insert(insertQuery.tableName, insertQuery.map);
  }

  Future<void> insertQueries(List<DatabaseInsertQuery> insertQueries) async {
    await checkIfOpen();
    for (var insertQuery in insertQueries) {
      await this.insertQuery(insertQuery);
    }
  }

  Future<List<Object?>> batchInsert(
      List<DatabaseInsertQuery> insertQueries) async {
    await checkIfOpen();
    var batch = _database!.batch();
    for (var insertQuery in insertQueries) {
      batch.insert(insertQuery.tableName, insertQuery.map);
    }
    return await batch.commit();
  }

  Future<T> transaction<T>(Future<T> Function(Transaction) action) async {
    await checkIfOpen();
    return await _database!.transaction(action);
  }

  Future<List<Map<String, Object?>>> queryTable(String tableName) async {
    await checkIfOpen();
    return await _database!.query(tableName);
  }

  Future<List<Map<String, Object?>>> queryRows(
      String tableName, String columnName, columnValue) async {
    await checkIfOpen();
    return await _database!
        .query(tableName, where: "$columnName = ?", whereArgs: [columnValue]);
  }

  Future<int?> delete(String tableName, String columnName, columnValue) async {
    await checkIfOpen();
    return await _database!
        .delete(tableName, where: "$columnName = ?", whereArgs: [columnValue]);
  }

  Future<void> checkIfOpen() async {
    if (_database == null || _database!.isOpen == false) {
      return await openDatabase();
    }
  }
}
