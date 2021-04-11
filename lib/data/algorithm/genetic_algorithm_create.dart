import 'cross.dart';
import 'elite_strategy.dart';
import 'genetic_algorithm.dart';
import 'grade_strategy.dart';
import 'inversion.dart';
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
  double inversionProbability;
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
      required this.inversionProbability,
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
      case Cross.ONE_POINT_CROSS:
        crossChoose = OnePointCross(crossProbability);
        break;

      case Cross.TWO_POINTS_CROSS:
        crossChoose = TwoPointsCross(crossProbability);
        break;

      case Cross.THREE_POINTS_CROSS:
        crossChoose = ThreePointsCross(crossProbability);
        break;

      case Cross.HOMOGENEOUS_CROSS:
        crossChoose = HomogeneousCross(crossProbability);
        break;
    }

    return crossChoose;
  }

  Mutation mutationChoose(mutation) {
    late Mutation mutationChoose;
    switch (mutation) {
      case Mutation.ONE_POINT_MUTATION:
        mutationChoose = OnePointMutation(mutationProbability);
        break;

      case Mutation.TWO_POINTS_MUTATION:
        mutationChoose = TwoPointsMutation(mutationProbability);
        break;

      case Mutation.EDGE_MUTATION:
        mutationChoose = EdgeMutation(mutationProbability);
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
    var inversion = Inversion(inversionProbability);
    var eliteStrategy = EliteStrategy(eliteStrategyAmount);
    var selection = chooseSelection(this.selection);
    var cross = crossChoose(this.cross);
    var mutation = mutationChoose(this.mutation);
    var gradeStrategy = gradeStrategyChoose(this.gradeStrategy);
    var population = Population(startRange, endRange, populationAmount);

    return GeneticAlgorithm(
            epochsAmount: epochsAmount,
            inversion: inversion,
            eliteStrategy: eliteStrategy,
            selection: selection,
            cross: cross,
            mutation: mutation,
            gradeStrategy: gradeStrategy,
            population: population)
        .runAlgorithm();
  }
}
