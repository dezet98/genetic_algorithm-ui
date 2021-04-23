import 'cross.dart';
import 'elite_strategy.dart';
import 'genetic_algorithm.dart';
import 'grade_strategy.dart';
import 'mutation.dart';
import 'population.dart';
import 'result.dart';
import 'selection.dart';

class GeneticAlgorithmCreate {
  double startRange;
  double endRange;
  int populationAmount;
  int epochsAmount;
  double selectionProbability;
  double crossProbability;
  double mutationProbability;
  int eliteStrategyAmount;
  String gradeStrategy;
  String selection;
  String cross;
  String mutation;

  GeneticAlgorithmCreate(
      {required this.startRange,
      required this.endRange,
      required this.populationAmount,
      required this.epochsAmount,
      required this.selectionProbability,
      required this.crossProbability,
      required this.mutationProbability,
      required this.eliteStrategyAmount,
      required this.gradeStrategy,
      required this.selection,
      required this.cross,
      required this.mutation});

  Selection chooseSelection(selection) {
    late Selection selectionChoose;
    switch (selection) {
      case Selection.BEST:
        selectionChoose = Best(selectionProbability);
        break;

      case Selection.ROULETTE:
        selectionChoose = Roulette(selectionProbability);
        break;

      case Selection.TOURNAMENT:
        selectionChoose = Tournament();
        break;
    }

    return selectionChoose;
  }

  Cross crossChoose(cross) {
    late Cross crossChoose;
    switch (cross) {
      case Cross.ARITHMETIC_CROSS:
        crossChoose = ArithmeticCross(crossProbability);
        break;

      case Cross.HEURISTIC_CROSS:
        crossChoose = HeuristicCross(crossProbability);
        break;
    }

    return crossChoose;
  }

  Mutation mutationChoose(mutation) {
    late Mutation mutationChoose;
    switch (mutation) {
      case Mutation.UNIFORM_MUTATION:
        mutationChoose = UniformMutation(mutationProbability);
        break;
    }

    return mutationChoose;
  }

  GradeStrategy gradeStrategyChoose(gradeStrategy) {
    late GradeStrategy gradeStrategyChoose;
    switch (gradeStrategy) {
      case GradeStrategy.MAXIMAL_GRADE:
        gradeStrategyChoose = MaximalGrade();
        break;

      case GradeStrategy.MINIMAL_GRADE:
        gradeStrategyChoose = MinimalGrade();
        break;
    }

    return gradeStrategyChoose;
  }

  Result createGeneticAlgorithm() {
    var eliteStrategy = EliteStrategy(eliteStrategyAmount);
    var selection = chooseSelection(this.selection);
    var cross = crossChoose(this.cross);
    var mutation = mutationChoose(this.mutation);
    var gradeStrategy = gradeStrategyChoose(this.gradeStrategy);
    var population = Population(startRange, endRange, populationAmount);

    return GeneticAlgorithm(
            epochsAmount: epochsAmount,
            eliteStrategy: eliteStrategy,
            selection: selection,
            cross: cross,
            mutation: mutation,
            gradeStrategy: gradeStrategy,
            population: population)
        .runAlgorithm();
  }
}
