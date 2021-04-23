import 'dart:math';

import 'package:genetic_algorithms/data/algorithm/grade_strategy.dart';

import 'chromosome.dart';
import 'population.dart';

abstract class Cross {
  static const ARITHMETIC_CROSS = 'arithmetic_cross';
  static const HEURISTIC_CROSS = 'heuristic_cross';

  static get items => [ARITHMETIC_CROSS, HEURISTIC_CROSS];

  Population cross(Population population, int populationSizeWithoutElite,
      GradeStrategy gradeStrategy);
}

class ArithmeticCross implements Cross {
  var crossProbability;
  var rnd = Random();

  ArithmeticCross(this.crossProbability);

  @override
  Population cross(Population population, int populationSizeWithoutElite,
      GradeStrategy gradeStrategy) {
    var newPopulation = Population.fromPopulation(
        population.startRange,
        population.endRange,
        population.populationAmount,
        population.chromosomes);

    var k = rnd.nextDouble();

    while (newPopulation.populationAmount < populationSizeWithoutElite) {
      var parents = <int>{};
      do {
        parents
            .add((rnd.nextDouble() * (newPopulation.populationAmount)).toInt());
      } while (parents.length != 2);
      var crossingChance = rnd.nextDouble();
      if (crossingChance <= crossProbability) {
        var x1 = newPopulation.chromosomes[parents.first].firstGenes;
        var y1 = newPopulation.chromosomes[parents.first].secondGenes;
        var x2 = newPopulation.chromosomes[parents.last].firstGenes;
        var y2 = newPopulation.chromosomes[parents.last].secondGenes;

        var x1new = k * x1 + (1 - k) * x2;
        var y1new = k * y1 + (1 - k) * y2;
        var x2new = (1 - k) * x1 + k * x2;
        var y2new = (1 - k) * y1 + k * y2;

        var firstChild = Chromosome(x1new, y1new);
        var secondChild = Chromosome(x2new, y2new);

        newPopulation.addChromosome(firstChild);
        newPopulation.addChromosome(secondChild);
      }
    }

    if (newPopulation.chromosomes.length != populationSizeWithoutElite) {
      newPopulation.chromosomes.removeLast();
      newPopulation.populationAmount = newPopulation.populationAmount - 1;
    }

    return newPopulation;
  }
}

class HeuristicCross implements Cross {
  var crossProbability;
  var rnd = Random();

  HeuristicCross(this.crossProbability);

  @override
  Population cross(Population population, int populationSizeWithoutElite,
      GradeStrategy gradeStrategy) {
    var newPopulation = Population.fromPopulation(
        population.startRange,
        population.endRange,
        population.populationAmount,
        population.chromosomes);

    var k = rnd.nextDouble();

    while (newPopulation.populationAmount < populationSizeWithoutElite) {
      var parents = <int>{};
      do {
        parents
            .add((rnd.nextDouble() * (newPopulation.populationAmount)).toInt());
      } while (parents.length != 2);
      var crossingChance = rnd.nextDouble();
      var x1 = newPopulation.chromosomes[parents.first].firstGenes;
      var y1 = newPopulation.chromosomes[parents.first].secondGenes;
      var x2 = newPopulation.chromosomes[parents.last].firstGenes;
      var y2 = newPopulation.chromosomes[parents.last].secondGenes;

      // var firstParentGrade = newPopulation.chromosomes[parents.first].grade;
      // var secondParentGrade = newPopulation.chromosomes[parents.last].grade;

      // if (secondParentGrade > firstParentGrade) {
      //   if (crossingChance <= crossProbability) {
      //     var x1new = k * (x2 - x1) + x2;
      //     var y1new = k * (y2 - y1) + y2;
      //     print("x1new $x1new");
      //     print("y1new $y1new");
      //
      //     var firstChild = Chromosome.withEvaluate(x1new, y1new);
      //     newPopulation.addChromosome(firstChild);
      //   }
      // }

      if (x2 >= x1 && y2 >= y1) {
        if (crossingChance <= crossProbability) {
          double x1new = k * (x2 - x1) + x1;
          double y1new = k * (y2 - y1) + y1;

          Chromosome firstChild = new Chromosome(x1new, y1new);
          newPopulation.addChromosome(firstChild);
        }
      }
      // gradeStrategy.evaluate(newPopulation);
    }

    if (newPopulation.chromosomes.length != populationSizeWithoutElite) {
      newPopulation.chromosomes.removeLast();
      newPopulation.populationAmount = newPopulation.populationAmount - 1;
    }

    return newPopulation;
  }
}
