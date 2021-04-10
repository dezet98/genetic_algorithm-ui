import 'package:genetic_algorithms/blocs/abstract/form/form_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/fields/check_field_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/fields/input_field_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/fields/select_field_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/result_save/result_save_bloc.dart';
import 'package:genetic_algorithms/data/algorithm/connection.dart';
import 'package:genetic_algorithms/data/algorithm/result.dart';
import 'package:genetic_algorithms/shared/platforms.dart';
import 'package:genetic_algorithms/shared/validators.dart';

enum FormItems {
  startRange,
  endRange,
  populationAmount,
  epochsAmount,
  selectionProbability,
  crossProbability,
  mutationProbability,
  inversionProbability,
  eliteStrategyAmount,
  gradeStrategy,
  selection,
  cross,
  mutation,
}

class AlgorithmParamsFormBloc extends FormBloc<Result> {
  ResultSaveBloc _resultSaveBloc;

  AlgorithmParamsFormBloc(this._resultSaveBloc)
      : super([
          InputFieldBloc<double>(
            key: FormItems.startRange,
            validator: (value) => DoubleValidator.valid(value),
            labelText: "Start range",
            initialValue: -10.0,
          ),
          InputFieldBloc<double>(
            key: FormItems.endRange,
            validator: (value) => DoubleValidator.valid(value),
            labelText: "End range",
            initialValue: 10.0,
          ),
          InputFieldBloc<int>(
            key: FormItems.populationAmount,
            validator: (value) => IntValidator.valid(value, min: 1),
            labelText: "Population amount",
            initialValue: 100,
          ),
          InputFieldBloc<int>(
            key: FormItems.epochsAmount,
            validator: (value) => IntValidator.valid(value, min: 1),
            labelText: "Epochs amount",
            initialValue: 100,
          ),
          InputFieldBloc<double>(
            key: FormItems.selectionProbability,
            validator: (value) => DoubleValidator.valid(value,
                errorText: "Schould be in range <0, 100>", min: 0, max: 100),
            labelText: "Selection probability",
            initialValue: 0.2,
          ),
          InputFieldBloc<double>(
            key: FormItems.crossProbability,
            validator: (value) => DoubleValidator.valid(value,
                errorText: "Schould be in range <0, 100>", min: 0, max: 100),
            labelText: "Cross probability",
            initialValue: 0.2,
          ),
          InputFieldBloc<double>(
            key: FormItems.mutationProbability,
            validator: (value) => DoubleValidator.valid(value,
                errorText: "Schould be in range <0, 100>", min: 0, max: 100),
            labelText: "Mutation probability",
            initialValue: 0.2,
          ),
          InputFieldBloc<double>(
            key: FormItems.inversionProbability,
            validator: (value) => DoubleValidator.valid(value,
                errorText: "Schould be in range <0, 100>", min: 0, max: 100),
            labelText: "Inversion probability",
            initialValue: 0.2,
          ),
          InputFieldBloc<int>(
            key: FormItems.eliteStrategyAmount,
            validator: (value) => IntValidator.valid(value),
            labelText: "Elite Strategy amount",
            initialValue: 3,
          ),
          SelectFieldBloc<String>(
            items: ['best', 'roulette', 'tournament'],
            initialValue: 'best',
            key: FormItems.selection,
            labelText: "Choose selection method",
          ),
          SelectFieldBloc<String>(
            items: ['one_point_cross', 'two_points_cross', 'three_points_cross', 'homogeneous_cross'],
            initialValue: 'one_point_cross',
            key: FormItems.cross,
            labelText: "Choose cross method",
          ),
          SelectFieldBloc<String>(
            items: ['one_point_mutation', 'two_points_mutation', 'edge_mutation'],
            initialValue: 'one_point_mutation',
            key: FormItems.mutation,
            labelText: "Choose mutation method",
          ),
          CheckFieldBloc(
            key: FormItems.gradeStrategy,
            titleText: "Maximization",
          )
        ]);

  @override
  Result onSubmit(Map<dynamic, Object?> results) {
    var result = Connection().connect(
      results[FormItems.startRange] as double,
      results[FormItems.endRange] as double,
      results[FormItems.populationAmount] as int,
      results[FormItems.epochsAmount] as int,
      results[FormItems.selectionProbability] as double,
      results[FormItems.crossProbability] as double,
      results[FormItems.mutationProbability] as double,
      results[FormItems.inversionProbability] as double,
      results[FormItems.eliteStrategyAmount] as int,
      results[FormItems.gradeStrategy] as bool,
      results[FormItems.selection] as String,
      results[FormItems.cross] as String,
      results[FormItems.mutation] as String,
    );

    if (PlatformInfo.isNotWeb) _resultSaveBloc.add(ResultSaveToEvent(result));
    return result;
  }
}
