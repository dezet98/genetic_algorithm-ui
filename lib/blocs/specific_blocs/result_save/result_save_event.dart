part of 'result_save_bloc.dart';

@immutable
abstract class ResultSaveEvent {}

class ResultSaveToEvent extends ResultSaveEvent {
  final Result _result;

  ResultSaveToEvent(this._result);
}
