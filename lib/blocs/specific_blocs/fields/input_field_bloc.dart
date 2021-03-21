import 'package:genetic_algorithms/blocs/abstract/field/field_bloc.dart';

class InputFieldBloc<T> extends FieldBloc<T> {
  String? hintText;
  String? labelText;
  String? helperText;

  InputFieldBloc({
    dynamic? key,
    T? initialValue,
    String? Function(T?)? validator,
    this.hintText,
    this.labelText,
    this.helperText,
  }) : super(validator, key, initialValue);
}
