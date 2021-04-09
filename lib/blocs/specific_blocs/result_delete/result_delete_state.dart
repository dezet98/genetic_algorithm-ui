part of 'result_delete_bloc.dart';

@immutable
abstract class ResultDeleteState {}

class ResultDeleteInitial extends ResultDeleteState {}

class ResultsDeleteInProgressState extends ResultDeleteState {}

class ResultsDeleteSuccesfullState extends ResultDeleteState {}

class ResultsDeleteFailureState extends ResultDeleteState {
  final LocalDatabaseError error;
  final String? message;

  ResultsDeleteFailureState(this.error, this.message);
}
