import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genetic_algorithms/shared/exceptions.dart';
import 'package:meta/meta.dart';

part 'local_database_save_event.dart';
part 'local_database_save_state.dart';

abstract class LocalDatabaseSaveBloc<SaveArgsType>
    extends Bloc<LocalDatabaseSaveEvent, LocalDatabaseSaveState> {
  LocalDatabaseSaveBloc() : super(LocalDatabaseSaveInitialState());

  Future<void> saveToDatabase(SaveArgsType args);

  @override
  Stream<LocalDatabaseSaveState> mapEventToState(
    LocalDatabaseSaveEvent event,
  ) async* {
    if (event is LocalDatabaseSaveDataEvent) {
      yield* mapLocalDatabaseSaveToEvent(event._saveArgs);
    }
  }

  Stream<LocalDatabaseSaveState> mapLocalDatabaseSaveToEvent(
      SaveArgsType args) async* {
    try {
      yield LocalDatabaseSaveInProgressState();
      await saveToDatabase(args);
      yield LocalDatabaseSaveSuccesfullState();
    } catch (e) {
      if (e is LocalDatabaseFailureException) {
        yield LocalDatabaseSaveFailureState(e.localDatabaseError, e.message);
      }
      yield LocalDatabaseSaveFailureState(
          LocalDatabaseError.UNDEFINED, e.toString());
    }
  }
}
