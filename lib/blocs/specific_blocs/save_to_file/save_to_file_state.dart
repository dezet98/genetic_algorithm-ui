part of 'save_to_file_bloc.dart';

@immutable
abstract class SaveToFileState {}

class SaveToFileInitialState extends SaveToFileState {}

class SaveToFileInProgressState extends SaveToFileState {}

class SaveToFileSuccesfullState extends SaveToFileState {}

class SaveToFileFailureState extends SaveToFileState {
  final FileError error;
  final String? message;

  SaveToFileFailureState(this.error, this.message);
}
