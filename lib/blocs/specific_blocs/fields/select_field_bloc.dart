import 'package:flutter/widgets.dart';
import 'package:genetic_algorithms/blocs/abstract/field/field_bloc.dart';

class SelectFieldBloc<T> extends FieldBloc<T> {
  List<T> items;
  Icon? icon;
  String? labelText;

  SelectFieldBloc({
    required this.items,
    required T initialValue,
    dynamic? key,
    String? Function(T?)? validator,
    this.icon,
    this.labelText,
  }) : super(validator, key, initialValue);
}
