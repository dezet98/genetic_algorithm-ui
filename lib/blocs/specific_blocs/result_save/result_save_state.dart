part of 'result_save_bloc.dart';

@immutable
abstract class ResultSaveState {}

class ResultSaveInitialState extends ResultSaveState {}

class ResultsSaveInProgressState extends ResultSaveState {}

class ResultsSaveSuccesfullState extends ResultSaveState {}

class ResultsSaveFailureState extends ResultSaveState {
  final LocalDatabaseError error;
  final String? message;

  ResultsSaveFailureState(this.error, this.message);
}
