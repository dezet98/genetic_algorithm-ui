part of 'results_bloc.dart';

@immutable
abstract class ResultsState {}

class ResultsInitialState extends ResultsState {}

class ResultsLoadingInProgressState extends ResultsState {}

class ResultsLoadingSuccesfullState extends ResultsState {
  final List<AlgorithmResult> algorithmResults;

  ResultsLoadingSuccesfullState(this.algorithmResults);
}

class ResultsLoadingFailureState extends ResultsState {
  final LocalDatabaseError error;
  final String? message;

  ResultsLoadingFailureState(this.error, this.message);
}
