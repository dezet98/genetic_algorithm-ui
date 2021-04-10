import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genetic_algorithms/shared/exceptions.dart';
import 'package:meta/meta.dart';

part 'local_database_delete_event.dart';
part 'local_database_delete_state.dart';

abstract class LocalDatabaseDeleteBloc<DeleteArgsType>
    extends Bloc<LocalDatabaseDeleteEvent, LocalDatabaseDeleteState> {
  LocalDatabaseDeleteBloc() : super(LocalDatabaseDeleteInitialState());

  Future<void> deleteFromDatabase(DeleteArgsType args);

  @override
  Stream<LocalDatabaseDeleteState> mapEventToState(
    LocalDatabaseDeleteEvent event,
  ) async* {
    if (event is LocalDatabaseDeleteDataEvent) {
      yield* mapLocalDatabaseDeleteItemEvent(event._deleteArgs);
    }
  }

  Stream<LocalDatabaseDeleteState> mapLocalDatabaseDeleteItemEvent(
      DeleteArgsType deleteArgsType) async* {
    try {
      yield LocalDatabaseDeleteInProgressState();

      await deleteFromDatabase(deleteArgsType);

      yield LocalDatabaseDeleteSuccesfullState();
    } catch (e) {
      if (e is LocalDatabaseFailureException) {
        yield LocalDatabaseDeleteFailureState(e.localDatabaseError, e.message);
      }
      yield LocalDatabaseDeleteFailureState(
          LocalDatabaseError.UNDEFINED, e.toString());
    }
  }
}
