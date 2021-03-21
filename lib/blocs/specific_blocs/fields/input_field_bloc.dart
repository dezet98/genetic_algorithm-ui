import 'package:genetic_algorithms/blocs/abstract/field/field_bloc.dart';

class InputFieldBloc<T> extends FieldBloc<T> {
  InputFieldBloc(T initialValue, String? Function(T?)? validator)
      : super(initialValue, validator);
}
