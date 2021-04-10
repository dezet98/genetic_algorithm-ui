part of 'local_database_get_bloc.dart';

@immutable
abstract class LocalDatabaseGetState {}

class LocalDatabaseGetInitialState extends LocalDatabaseGetState {}

class LocalDatabaseGetInProgressState extends LocalDatabaseGetState {}

class LocalDatabaseGetSuccesfullState<T> extends LocalDatabaseGetState {
  final T results;

  LocalDatabaseGetSuccesfullState(this.results);
}

class LocalDatabaseGetFailureState extends LocalDatabaseGetState {
  final LocalDatabaseError error;
  final String? message;

  LocalDatabaseGetFailureState(this.error, this.message);
}
