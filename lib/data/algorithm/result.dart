import 'package:genetic_algorithms/data/models/algorithm_result.dart';
import 'package:genetic_algorithms/data/models/average_in_epoch.dart';
import 'package:genetic_algorithms/data/models/best_in_epoch.dart';
import 'package:genetic_algorithms/data/models/standard_deviation.dart';

class Result {
  late int epochsAmount;
  late int populationSize;
  late String algorithmTime;
  late List<double> bestInEpoch = [];
  late List<double> averageInEpoch = [];
  late List<double> standardDeviation = [];

  Result(
      {required this.epochsAmount,
      required this.populationSize,
      required this.algorithmTime,
      required this.bestInEpoch,
      required this.averageInEpoch,
      required this.standardDeviation});

  AlgorithmResult get algorithmResult => AlgorithmResult(
      epochsAmount: epochsAmount,
      populationSize: populationSize,
      algorithmTime: algorithmTime);

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
