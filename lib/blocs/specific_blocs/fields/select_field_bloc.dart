import 'package:genetic_algorithms/blocs/abstract/field/field_bloc.dart';

class SelectFieldBloc<T> extends FieldBloc<T> {
  List<T> items;

  SelectFieldBloc(this.items, T initialValue, String? Function(T?)? validator)
      : super(initialValue, validator);
}
