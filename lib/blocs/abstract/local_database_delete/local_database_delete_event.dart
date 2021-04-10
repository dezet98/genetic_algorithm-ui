part of 'local_database_delete_bloc.dart';

@immutable
abstract class LocalDatabaseDeleteEvent {}

class LocalDatabaseDeleteDataEvent<T> extends LocalDatabaseDeleteEvent {
  final T _deleteArgs;

  LocalDatabaseDeleteDataEvent(this._deleteArgs);
}
