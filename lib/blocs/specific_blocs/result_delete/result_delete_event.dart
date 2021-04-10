part of 'result_delete_bloc.dart';

@immutable
abstract class ResultDeleteEvent {}

class ResultDeleteItemEvent extends ResultDeleteEvent {
  final AlgorithmResult _algorithmResult;

  ResultDeleteItemEvent(this._algorithmResult);
}
