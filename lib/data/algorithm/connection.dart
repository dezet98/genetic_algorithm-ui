import 'cross.dart';
import 'genetic_algorithm_create.dart';
import 'grade_strategy.dart';
import 'mutation.dart';
import 'result.dart';
import 'selection.dart';

class Connection {
  Connection();

  Result connect() {
    return GeneticAlgorithmCreate(
      startRange: -10,
      endRange: 10,
      populationAmount: 10,
      epochsAmount: 10,
      selectionProbability: 0.5,
      crossProbability: 0.2,
      mutationProbability: 0.2,
      inversionProbability: 0.2,
      eliteStrategyAmount: 1,
      gradeStrategy: GradeStrategy.MAXIMAL_GRADE,
      selection: Selection.TOURNAMENT,
      cross: Cross.HOMOGENEOUS_CROSS,
      mutation: Mutation.EDGE_MUTATION,
    ).createGeneticAlgorithm();
  }
}
