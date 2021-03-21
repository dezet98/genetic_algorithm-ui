import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'field_event.dart';
part 'field_state.dart';

abstract class FieldBloc<T> extends Bloc<FieldEvent, FieldState> {
  late T? _value;
  final dynamic? key;
  final T? initialValue;
  final String? Function(T?)? validator;

  FieldBloc(this.validator, this.key, this.initialValue)
      : super(FieldInitialState()) {
    _value = initialValue;
  }

  T? get value => _value;
  bool get isValid => validator == null ? true : validator!(_value) == null;
  bool get isInvalid => validator == null ? false : validator!(_value) != null;

  @override
  Stream<FieldState> mapEventToState(
    FieldEvent event,
  ) async* {
    if (event is FieldClearEvent) {
      _value = initialValue;
      yield FieldClearedState();
    } else if (event is FieldChangeEvent) {
      _value = event.newValue;
      yield FieldChangedState();
    }
  }
}
