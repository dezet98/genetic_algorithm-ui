part of 'local_database_save_bloc.dart';

@immutable
abstract class LocalDatabaseSaveState {}

class LocalDatabaseSaveInitialState extends LocalDatabaseSaveState {}

class LocalDatabaseSaveInProgressState extends LocalDatabaseSaveState {}

class LocalDatabaseSaveSuccesfullState extends LocalDatabaseSaveState {}

class LocalDatabaseSaveFailureState extends LocalDatabaseSaveState {
  final LocalDatabaseError error;
  final String? message;

  LocalDatabaseSaveFailureState(this.error, this.message);
}
