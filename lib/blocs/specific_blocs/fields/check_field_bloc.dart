import 'package:genetic_algorithms/blocs/abstract/field/field_bloc.dart';

class CheckFieldBloc extends FieldBloc<bool> {
  final String titleText;

  CheckFieldBloc({
    dynamic? key,
    required this.titleText,
    bool initialValue = true,
  }) : super(null, key, initialValue);
}
