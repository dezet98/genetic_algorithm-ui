part of 'local_database_delete_bloc.dart';

@immutable
abstract class LocalDatabaseDeleteState {}

class LocalDatabaseDeleteInitialState extends LocalDatabaseDeleteState {}

class LocalDatabaseDeleteInProgressState extends LocalDatabaseDeleteState {}

class LocalDatabaseDeleteSuccesfullState extends LocalDatabaseDeleteState {}

class LocalDatabaseDeleteFailureState extends LocalDatabaseDeleteState {
  final LocalDatabaseError error;
  final String? message;

  LocalDatabaseDeleteFailureState(this.error, this.message);
}
