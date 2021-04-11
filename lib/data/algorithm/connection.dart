import 'genetic_algorithm_create.dart';
import 'result.dart';

class Connection {
  Result connect(
      double startRange,
      double endRange,
      int populationAmount,
      int epochsAmount,
      double selectionProbability,
      double crossProbability,
      double mutationProbability,
      double inversionProbability,
      int eliteStrategyAmount,
      bool gradeStrategy,
      String selection,
      String cross,
      String mutation) {
    return GeneticAlgorithmCreate(
      startRange: startRange,
      endRange: endRange,
      populationAmount: populationAmount,
      epochsAmount: epochsAmount,
      selectionProbability: selectionProbability,
      crossProbability: crossProbability,
      mutationProbability: mutationProbability,
      inversionProbability: inversionProbability,
      eliteStrategyAmount: eliteStrategyAmount,
      gradeStrategy: gradeStrategy ? 'maximal_grade' : 'minimal_grade',
      selection: 'best',
      cross: cross,
      mutation: mutation,
    ).createGeneticAlgorithm();
  }
}
