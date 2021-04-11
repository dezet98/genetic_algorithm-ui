import 'package:genetic_algorithms/data/local_database/database.dart';
import 'package:genetic_algorithms/data/local_database/database_actions.dart';
import 'package:genetic_algorithms/shared/exceptions.dart';
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
      throw LocalDatabaseFailureException(
        LocalDatabaseError.OPEN_DATABASE_ERROR,
        "",
      );
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

  Future<void> _checkIfOpen() async {
    if (_database == null || _database!.isOpen == false) {
      return await openDatabase();
    }
  }

  // insert
  Future<int> _insert(DatabaseInsertAction insertAction, dynamic x) async {
    return await x.insert(insertAction.tableName, insertAction.map);
  }

  Future<int> insertQuery(DatabaseInsertAction databaseInsertAction) async {
    await _checkIfOpen();
    return await _insert(databaseInsertAction, _database!);
  }

  Future<void> insertQueries(
      List<DatabaseInsertAction> databaseInsertActions) async {
    await _checkIfOpen();
    for (var insertAction in databaseInsertActions) {
      await _insert(insertAction, _database!);
    }
  }

  // query
  Future<List<Map<String, Object?>>> _query(
      DatabaseQueryAction queryAction, dynamic x) async {
    return await x.query(
      queryAction.tableName,
      where: queryAction.columnName != null
          ? "${queryAction.columnName} = ?"
          : null,
      whereArgs:
          queryAction.columnName != null ? [queryAction.columnValue] : null,
    );
  }

  Future<List<Map<String, Object?>>> query(
      DatabaseQueryAction databaseQueryAction) async {
    await _checkIfOpen();
    return await _query(databaseQueryAction, _database!);
  }

// delete
  Future<int?> _delete(DatabaseDeleteAction deleteAction, dynamic x) async {
    return await x.delete(
      deleteAction.tableName,
      where: deleteAction.columnName != null
          ? "${deleteAction.columnName} = ?"
          : null,
      whereArgs:
          deleteAction.columnName != null ? [deleteAction.columnValue] : null,
    );
  }

  Future<int?> delete(DatabaseDeleteAction deleteAction) async {
    await _checkIfOpen();
    return await _delete(deleteAction, _database!);
  }

  // batch
  Future<List<Object?>> batch(List<DatabaseAction> actions) async {
    await _checkIfOpen();
    var batch = _database!.batch();
    for (var action in actions) {
      await _transformDatabaseAction(batch, action);
    }
    return await batch.commit();
  }

  Future<void> _transformDatabaseAction(
      Batch batch, DatabaseAction databaseAction) async {
    switch (databaseAction.type) {
      case DatabaseQueryTypes.insert:
        await _insert(databaseAction as DatabaseInsertAction, batch);
        break;
      case DatabaseQueryTypes.delete:
        await _delete(databaseAction as DatabaseDeleteAction, batch);
        break;
      case DatabaseQueryTypes.query:
        await _query(databaseAction as DatabaseQueryAction, batch);
        break;
    }
  }
}
