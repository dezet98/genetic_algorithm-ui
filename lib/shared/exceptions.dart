enum LocalDatabaseError { UNDEFINED }

class LocalDatabaseFailureException implements Exception {
  LocalDatabaseError localDatabaseError;
  String? message;

  LocalDatabaseFailureException(this.localDatabaseError, this.message);
}
