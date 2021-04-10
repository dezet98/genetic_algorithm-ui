enum LocalDatabaseError { UNDEFINED, GET_FROM_DATABASE_CAST_ERROR }

class LocalDatabaseFailureException implements Exception {
  LocalDatabaseError localDatabaseError;
  String? message;

  LocalDatabaseFailureException(this.localDatabaseError, this.message);
}
