part of 'local_database_save_bloc.dart';

@immutable
abstract class LocalDatabaseSaveEvent {}

class LocalDatabaseSaveDataEvent<T> extends LocalDatabaseSaveEvent {
  final T _saveArgs;

  LocalDatabaseSaveDataEvent(this._saveArgs);
}

class LocalDatabaseSaveArgs {}
