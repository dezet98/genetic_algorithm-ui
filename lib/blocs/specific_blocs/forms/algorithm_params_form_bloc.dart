import 'package:flutter/foundation.dart';
import 'package:genetic_algorithms/blocs/abstract/form/form_bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/local_database_save/local_database_save_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/fields/check_field_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/fields/input_field_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/fields/select_field_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/result/result_save_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/save_to_file/save_to_file_bloc.dart';
import 'package:genetic_algorithms/data/algorithm/connection.dart';
import 'package:genetic_algorithms/data/algorithm/cross.dart';
import 'package:genetic_algorithms/data/algorithm/mutation.dart';
import 'package:genetic_algorithms/data/algorithm/result.dart';
import 'package:genetic_algorithms/data/algorithm/selection.dart';
import 'package:genetic_algorithms/data/models/algorithm_params.dart';
import 'package:genetic_algorithms/data/models/algorithm_result.dart';
import 'package:genetic_algorithms/data/models/average_in_epoch.dart';
import 'package:genetic_algorithms/data/models/best_in_epoch.dart';
import 'package:genetic_algorithms/data/models/standard_deviation.dart';
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

class AlgorithmParamsFormBlocData {
  AlgorithmResult algorithmResult;
  List<BestInEpoch> bestInEpochs;
  List<AverageInEpoch> averageInEpochs;
  List<StandardDeviation> standardDeviations;

  AlgorithmParamsFormBlocData(this.algorithmResult, this.averageInEpochs,
      this.bestInEpochs, this.standardDeviations);
}

class AlgorithmParamsFormBloc extends FormBloc<AlgorithmParamsFormBlocData> {
  ResultSaveBloc _resultSaveBloc;
  SaveToFileBloc _saveToFileBloc;

  AlgorithmParamsFormBloc(this._resultSaveBloc, this._saveToFileBloc)
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
          InputFieldBloc<int>(
            key: FormItems.eliteStrategyAmount,
            validator: (value) => IntValidator.valid(value),
            labelText: "Elite Strategy amount",
            initialValue: 3,
          ),
          SelectFieldBloc<String>(
            items: Selection.items,
            getName: (v) {
              switch (v) {
                case Selection.BEST:
                  return "Best";
                case Selection.ROULETTE:
                  return "Roulette";
                case Selection.TOURNAMENT:
                  return "Tournament";
                default:
                  return "-";
              }
            },
            initialValue: Selection.BEST,
            key: FormItems.selection,
            labelText: "Choose selection method",
          ),
          SelectFieldBloc<String>(
            items: Cross.items,
            getName: (v) {
              switch (v) {
                case Cross.ARITHMETIC_CROSS:
                  return "Arithmetic";
                case Cross.HEURISTIC_CROSS:
                  return "Heuristic";
                default:
                  return "-";
              }
            },
            initialValue: Cross.ARITHMETIC_CROSS,
            key: FormItems.cross,
            labelText: "Choose cross method",
          ),
          SelectFieldBloc<String>(
            items: Mutation.items,
            getName: (v) {
              switch (v) {
                case Mutation.UNIFORM_MUTATION:
                  return "Uniform";
                default:
                  return "-";
              }
            },
            initialValue: Mutation.UNIFORM_MUTATION,
            key: FormItems.mutation,
            labelText: "Choose mutation method",
          ),
          CheckFieldBloc(
            key: FormItems.gradeStrategy,
            titleText: "Maximization",
          )
        ]);

  @override
  Future<AlgorithmParamsFormBlocData> onSubmit(
      Map<dynamic, Object?> results) async {
    AlgorithmParams params = getParams(results);
    Result computeFuture = await computeOnMainIsolate(params);

    if (PlatformInfo.isNotWeb)
      _resultSaveBloc.add(
        LocalDatabaseSaveDataEvent(ResultSaveBlocArgs(computeFuture, params)),
      );

    _saveToFileBloc
        .add(SaveToFileDataEvent(computeFuture.chromosomesInEachEpoch));

    AlgorithmResult algorithmResult = computeFuture.algorithmResult;
    algorithmResult.algorithmParams = params;

    return AlgorithmParamsFormBlocData(
      algorithmResult,
      computeFuture.averageInEpochs(null),
      computeFuture.bestInEpochs(null),
      computeFuture.standardDeviations(null),
    );
  }
}

Future<Result> computeOnMainIsolate(AlgorithmParams results) async {
  return await compute(runAlgorithm, results);
}

Result runAlgorithm(AlgorithmParams params) {
  return Connection().connect(
    params.startRange,
    params.endRange,
    params.populationAmount,
    params.epochsAmount,
    params.selectionProbability,
    params.crossProbability,
    params.mutationProbability,
    params.eliteStrategyAmount,
    params.gradeStrategy,
    params.selection,
    params.cross,
    params.mutation,
  );
}

AlgorithmParams getParams(Map<dynamic, Object?> results) {
  return AlgorithmParams(
    startRange: results[FormItems.startRange] as double,
    endRange: results[FormItems.endRange] as double,
    populationAmount: results[FormItems.populationAmount] as int,
    epochsAmount: results[FormItems.epochsAmount] as int,
    selectionProbability: results[FormItems.selectionProbability] as double,
    crossProbability: results[FormItems.crossProbability] as double,
    mutationProbability: results[FormItems.mutationProbability] as double,
    eliteStrategyAmount: results[FormItems.eliteStrategyAmount] as int,
    gradeStrategy: results[FormItems.gradeStrategy] as bool,
    selection: results[FormItems.selection] as String,
    cross: results[FormItems.cross] as String,
    mutation: results[FormItems.mutation] as String,
  );
}
