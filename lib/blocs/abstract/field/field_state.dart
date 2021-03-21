part of 'field_bloc.dart';

@immutable
abstract class FieldState {}

class FieldInitialState extends FieldState {}

class FieldChangedState implements FieldState {}

class FieldClearedState implements FieldState {}
