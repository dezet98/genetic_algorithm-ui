import 'package:genetic_algorithms/blocs/abstract/form/form_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/fields/input_field_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/fields/select_field_bloc.dart';

class AlgorithmParamsFormBloc extends FormBloc {
  AlgorithmParamsFormBloc()
      : super([
          InputFieldBloc<String>(
              "initialValue", (value) => value!.isEmpty ? "Error" : null),
          SelectFieldBloc<String>(['one', 'two', 'three'], 'two', (_) => null),
          InputFieldBloc<double>(3.3, (value) => _doubleValidator(value)),
        ]);

  @override
  void onSubmit() {
    print("submit");
  }

  static String? _doubleValidator(double? value) {
    try {
      if (value != null && value < 10) {
        return null;
      }
      return "Error";
    } catch (e) {
      print(e);
    }
  }
}
