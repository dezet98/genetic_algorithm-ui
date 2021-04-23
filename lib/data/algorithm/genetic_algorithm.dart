import 'package:genetic_algorithms/data/algorithm/units.dart';

import 'cross.dart';
import 'elite_strategy.dart';
import 'grade_strategy.dart';
import 'mutation.dart';
import 'population.dart';
import 'result.dart';
import 'selection.dart';

class GeneticAlgorithm {
  int epochsAmount;
  EliteStrategy eliteStrategy;
  Selection selection;
  Cross cross;
  Mutation mutation;
  GradeStrategy gradeStrategy;
  Population population;
  List<double> bestInEpoch = [];
  List<double> averageInEpoch = [];
  List<double> standardDeviation = [];
  late int populationSizeWithoutElite;
  late List<List<double>> chromosomesInEachEpoch = [];

  GeneticAlgorithm(
      {required this.epochsAmount,
      required this.eliteStrategy,
      required this.selection,
      required this.cross,
      required this.mutation,
      required this.gradeStrategy,
      required this.population}) {
    populationSizeWithoutElite =
        population.populationAmount - eliteStrategy.eliteStrategyAmount;
  }

  Result runAlgorithm() {
    final stopwatch = Stopwatch()..start();

    for (var i = 1; i <= epochsAmount; i++) {
      gradeStrategy.evaluate(population);
      chromosomesInEachEpoch.add(addPopulation(population));
      bestInEpoch.add(findTheBest(population));
      averageInEpoch.add(calculateAverage(population));
      standardDeviation.add(calculateStandardDeviation(population));

      // printPopulation('************** Początek epoki $i **************', population);

      population = eliteStrategy.getBestFromPopulation(population);
      // printPopulation( 'Po Elite: ', population,);

      population = selection.selection(population);
      // printPopulation('Po selekcji', population);

      population = cross.cross(population, populationSizeWithoutElite, gradeStrategy);
      gradeStrategy.evaluate(population);
      // printPopulation('Po cross', population);

      mutation.mutation(population);
      gradeStrategy.evaluate(population);
      // printPopulation('Po mutacji', population);


      eliteStrategy.setBestToPopulation(population);
      // printPopulation('Dodanie najlepszych', population);
    }
    gradeStrategy.evaluate(population);
    bestInEpoch.add(findTheBest(population));
    averageInEpoch.add(calculateAverage(population));
    standardDeviation.add(calculateStandardDeviation(population));

    // printPopulation('********** Ostateczna populacja *******', population);

    var result = Result(
        epochsAmount: epochsAmount,
        populationSize: population.populationAmount,
        algorithmTime: (stopwatch.elapsed.inMilliseconds / 1000).toString(),
        best: findTheBest(population),
        dataTime: DateTime.now(),
        bestAverage: calculateAverageForBest(bestInEpoch),
        bestInEpoch: bestInEpoch,
        averageInEpoch: averageInEpoch,
        standardDeviation: standardDeviation,
        chromosomesInEachEpoch: chromosomesInEachEpoch);

    return result;
  }
}
