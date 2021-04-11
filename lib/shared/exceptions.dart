enum LocalDatabaseError {
  OPEN_DATABASE_ERROR,
  UNDEFINED,
  GET_FROM_DATABASE_CAST_ERROR,
  DELETE_ERROR
}

enum RouterError {
  UNDEFINED,
  ARGS_ERROR,
}

enum FileError {
  UNDEFINED,
}

class LocalDatabaseFailureException implements Exception {
  LocalDatabaseError localDatabaseError;
  String? message;

  LocalDatabaseFailureException(this.localDatabaseError, this.message);
}

class RouterException implements Exception {
  RouterError routerError;
  String? message;

  RouterException(this.routerError, this.message);
}

class SaveToFileException implements Exception {
  FileError fileError;
  String? message;

  SaveToFileException(this.fileError, this.message);
}
