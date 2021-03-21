part of 'field_bloc.dart';

@immutable
abstract class FieldEvent {}

class FieldChangeEvent<T> implements FieldEvent {
  final T newValue;

  FieldChangeEvent(this.newValue);
}

class FieldClearEvent implements FieldEvent {}
