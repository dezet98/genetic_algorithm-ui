import 'package:genetic_algorithms/blocs/abstract/form/form_bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/local_database_save/local_database_save_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/fields/check_field_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/fields/input_field_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/fields/select_field_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/result/result_save_bloc.dart';
import 'package:genetic_algorithms/data/algorithm/connection.dart';
import 'package:genetic_algorithms/data/algorithm/result.dart';
import 'package:genetic_algorithms/shared/platforms.dart';
import 'package:genetic_algorithms/shared/validators.dart';

enum FormItems {
  startRange,
  endRange,
  populationAmount,
  bitsNumber,
  epochsAmount,
  chromosomeAmount,
  eliteStrategyAmount,
  crossProbability,
  mutationProbability,
  inversionProbability,
  selectionMethod,
  mutationMethod,
  crossMethod,
  maximization,
}

class AlgorithmParamsFormBloc extends FormBloc<Result> {
  ResultSaveBloc _resultSaveBloc;

  AlgorithmParamsFormBloc(this._resultSaveBloc)
      : super([
          InputFieldBloc<double>(
            key: FormItems.startRange,
            validator: (value) => DoubleValidator.valid(value),
            labelText: "Start range",
            initialValue: 1.0,
          ),
          InputFieldBloc<double>(
            key: FormItems.endRange,
            validator: (value) => DoubleValidator.valid(value),
            labelText: "End range",
            initialValue: 1.0,
          ),
          InputFieldBloc<int>(
            key: FormItems.populationAmount,
            validator: (value) => IntValidator.valid(value, min: 1),
            labelText: "Population amount",
            initialValue: 1,
          ),
          InputFieldBloc<int>(
            key: FormItems.bitsNumber,
            validator: (value) => IntValidator.valid(value, min: 1),
            labelText: "Number of bits",
            initialValue: 1,
          ),
          InputFieldBloc<int>(
            key: FormItems.epochsAmount,
            validator: (value) => IntValidator.valid(value, min: 1),
            labelText: "Epochs amount",
            initialValue: 1,
          ),
          InputFieldBloc<double>(
            key: FormItems.chromosomeAmount,
            validator: (value) => DoubleValidator.valid(value, min: 0),
            labelText: "Best and tournament chromosome amount",
            initialValue: 1.0,
          ),
          InputFieldBloc<int>(
            key: FormItems.eliteStrategyAmount,
            validator: (value) => IntValidator.valid(value),
            labelText: "Elite Strategy amount",
            initialValue: 1,
          ),
          InputFieldBloc<double>(
            key: FormItems.crossProbability,
            validator: (value) => DoubleValidator.valid(value,
                errorText: "Schould be in range <0, 100>", min: 0, max: 100),
            labelText: "Cross probability",
            initialValue: 1.0,
          ),
          InputFieldBloc<double>(
            key: FormItems.mutationProbability,
            validator: (value) => DoubleValidator.valid(value,
                errorText: "Schould be in range <0, 100>", min: 0, max: 100),
            labelText: "Mutation probability",
            initialValue: 1.0,
          ),
          InputFieldBloc<double>(
            key: FormItems.inversionProbability,
            validator: (value) => DoubleValidator.valid(value,
                errorText: "Schould be in range <0, 100>", min: 0, max: 100),
            labelText: "Inversion probability",
            initialValue: 1.0,
          ),
          SelectFieldBloc<String>(
            items: ['BEST', 'ROULETTE', 'TOURNAMENT'],
            initialValue: 'BEST',
            key: FormItems.selectionMethod,
            labelText: "Choose selection method",
          ),
          SelectFieldBloc<String>(
            items: ['ONE_POINT', 'TWO_POINTS', 'THREE_POINTS', 'HOMO'],
            initialValue: 'ONE_POINT',
            key: FormItems.crossMethod,
            labelText: "Choose cross method",
          ),
          SelectFieldBloc<String>(
            items: ['ONE_POINT', 'TWO_POINTS'],
            initialValue: 'ONE_POINT',
            key: FormItems.mutationMethod,
            labelText: "Choose mutation method",
          ),
          CheckFieldBloc(
            key: FormItems.maximization,
            titleText: "Maximization",
          )
        ]);

  @override
  Result onSubmit(Map<dynamic, Object?> results) {
    var result = Connection().connect();

    if (PlatformInfo.isNotWeb)
      _resultSaveBloc.add(LocalDatabaseSaveDataEvent(result));
    return result;
  }
}
