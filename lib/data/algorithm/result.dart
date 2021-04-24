import 'package:genetic_algorithms/data/models/algorithm_result.dart';
import 'package:genetic_algorithms/data/models/average_in_epoch.dart';
import 'package:genetic_algorithms/data/models/best_in_epoch.dart';
import 'package:genetic_algorithms/data/models/standard_deviation.dart';

class Result {
  late int epochsAmount;
  late int populationSize;
  late String algorithmTime;
  late double best;
  late DateTime dataTime;
  late double bestAverage;
  late List<double> bestInEpoch = [];
  late List<double> averageInEpoch = [];
  late List<double> standardDeviation = [];
  late List<List<double>> chromosomesInEachEpoch = [];

  Result({
    required this.epochsAmount,
    required this.populationSize,
    required this.algorithmTime,
    required this.best,
    required this.dataTime,
    required this.bestAverage,
    required this.bestInEpoch,
    required this.averageInEpoch,
    required this.standardDeviation,
    required this.chromosomesInEachEpoch,
  });

  AlgorithmResult get algorithmResult => AlgorithmResult(
        algorithmTime: algorithmTime,
        best: best,
        bestAverage: bestAverage,
        creationTime: dataTime,
      );

  List<BestInEpoch> bestInEpochs(int? resultId) {
    return List.generate(
      bestInEpoch.length,
      (index) => BestInEpoch(
        resultId: resultId,
        epoch: index,
        value: bestInEpoch[index],
      ),
    );
  }

  List<AverageInEpoch> averageInEpochs(int? resultId) {
    return List.generate(
      bestInEpoch.length,
      (index) => AverageInEpoch(
        resultId: resultId,
        epoch: index,
        value: averageInEpoch[index],
      ),
    );
  }

  List<StandardDeviation> standardDeviations(int? resultId) {
    return List.generate(
      bestInEpoch.length,
      (index) => StandardDeviation(
        resultId: resultId,
        epoch: index,
        value: standardDeviation[index],
      ),
    );
  }
}
