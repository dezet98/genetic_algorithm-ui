import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genetic_algorithms/shared/exceptions.dart';
import 'package:meta/meta.dart';

part 'local_database_get_event.dart';
part 'local_database_get_state.dart';

abstract class LocalDatabaseGetBloc<GetResultType>
    extends Bloc<LocalDatabaseGetEvent, LocalDatabaseGetState> {
  LocalDatabaseGetBloc() : super(LocalDatabaseGetInitialState()) {
    add(LocalDatabaseGetRefreshEvent());
  }

  Future<GetResultType> getFromDatabase();

  @override
  Stream<LocalDatabaseGetState> mapEventToState(
    LocalDatabaseGetEvent event,
  ) async* {
    if (event is LocalDatabaseGetRefreshEvent) {
      yield* mapLocalDatabaseGetRefreshEvent();
    }
  }

  Stream<LocalDatabaseGetState> mapLocalDatabaseGetRefreshEvent() async* {
    try {
      yield LocalDatabaseGetInProgressState();

      GetResultType result = await getFromDatabase();

      yield LocalDatabaseGetSuccesfullState(result);
    } catch (e) {
      if (e is LocalDatabaseFailureException) {
        yield LocalDatabaseGetFailureState(e.localDatabaseError, e.message);
      }
      yield LocalDatabaseGetFailureState(
          LocalDatabaseError.UNDEFINED, e.toString());
    }
  }
}
