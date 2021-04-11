import 'dart:io';

import 'package:genetic_algorithms/data/algorithm/units.dart';

import 'cross.dart';
import 'elite_strategy.dart';
import 'grade_strategy.dart';
import 'inversion.dart';
import 'mutation.dart';
import 'population.dart';
import 'result.dart';
import 'selection.dart';

class GeneticAlgorithm {
  int epochsAmount;
  Inversion inversion;
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
  late File file;
  late var partialPath;
  late var path;
  late List<List<double>> chromosomesInEachEpoch = [];

  GeneticAlgorithm({required this.epochsAmount,
    required this.inversion,
    required this.eliteStrategy,
    required this.selection,
    required this.cross,
    required this.mutation,
    required this.gradeStrategy,
    required this.population}) {
    populationSizeWithoutElite =
        population.getPopulationAmount() - eliteStrategy.eliteStrategyAmount;
  }

  Future<Result> runAlgorithm() async {
    final stopwatch = Stopwatch()
      ..start();
    final File file = await initFile();

    for (var i = 1; i <= epochsAmount; i++) {
      gradeStrategy.evaluate(population);
      chromosomesInEachEpoch.add(addPopulation(population));
      bestInEpoch.add(findTheBest(population));
      averageInEpoch.add(calculateAverage(population));
      standardDeviation.add(calculateStandardDeviation(population));

      // printPopulation('************** Początek epoki $i **************');

      population = eliteStrategy.getBestFromPopulation(population);
      // //printPopulation(population, gradeStrategy, 'Po Elite: ');

      population = selection.selection(population);
      //printPopulation(population, gradeStrategy, 'Po selekcji');

      population = cross.cross(population, populationSizeWithoutElite);
      gradeStrategy.evaluate(population);
      //printPopulation(population, gradeStrategy, 'Po cross');

      mutation.mutation(population);
      gradeStrategy.evaluate(population);
      //printPopulation(population, gradeStrategy, 'Po mutacji');

      inversion.inversion(population);
      gradeStrategy.evaluate(population);
      //printPopulation(population, gradeStrategy, 'Po inwersji');

      eliteStrategy.setBestToPopulation(population);
      //printPopulation(population, gradeStrategy, 'Dodanie najlepszych');


    }
    gradeStrategy.evaluate(population);
    bestInEpoch.add(findTheBest(population));
    averageInEpoch.add(calculateAverage(population));
    standardDeviation.add(calculateStandardDeviation(population));

    // printPopulation('********** Ostateczna populacja *******');

    var result = Result(
        epochsAmount: epochsAmount,
        populationSize: population.getPopulationAmount(),
        algorithmTime: (stopwatch.elapsed.inMilliseconds / 1000).toString(),
        best: findTheBest(population),
        dataTime:  DateTime.now(),
        bestAverage: calculateAverageForBest(bestInEpoch),
        bestInEpoch: bestInEpoch,
        averageInEpoch: averageInEpoch,
        standardDeviation: standardDeviation,
        chromosomesInEachEpoch: chromosomesInEachEpoch);

    print(result.epochsAmount);
    print(result.populationSize);
    print(result.algorithmTime);
    print(result.best);
    print(result.dataTime);
    print(result.bestAverage);
    print(result.bestInEpoch);
    print(result.averageInEpoch);
    print(result.standardDeviation);
    print(result.chromosomesInEachEpoch);
    return result;
  }
}
