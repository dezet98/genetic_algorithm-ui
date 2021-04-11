part of 'save_to_file_bloc.dart';

@immutable
abstract class SaveToFileEvent {}

class SaveToFileDataEvent extends SaveToFileEvent {
  final List<List<double>> chromosomesInEachEpoch;

  SaveToFileDataEvent(this.chromosomesInEachEpoch);
}
