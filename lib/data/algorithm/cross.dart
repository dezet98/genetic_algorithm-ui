import 'dart:collection';
import 'dart:math';

import 'chromosome.dart';
import 'population.dart';

abstract class Cross {
  static const ONE_POINT_CROSS = 'one_point_cross';
  static const TWO_POINTS_CROSS = 'two_points_cross';
  static const THREE_POINTS_CROSS = 'three_points_cross';
  static const HOMOGENEOUS_CROSS = 'homogeneous_cross';

  Population cross(Population population, int populationSizeWithoutElite);
}

// jednorodne, jednopunktowe
class OnePointCross implements Cross {
  var crossProbability;
  var rnd = Random();

  OnePointCross(this.crossProbability);

  @override
  Population cross(Population population, int populationSizeWithoutElite) {
    var newPopulation = Population.fromPopulation(
        population.startRange,
        population.endRange,
        population.getPopulationAmount(),
        population.chromosomeSize,
        population.getChromosomes());

    while (newPopulation.getPopulationAmount() < populationSizeWithoutElite) {
      var parents = <int>{};
      do {
        parents.add(
            (rnd.nextDouble() * (newPopulation.getPopulationAmount())).toInt());
      } while (parents.length != 2);
      var crossingChance = rnd.nextDouble();
      if (crossingChance <= crossProbability) {
        var firstNewChromosome = <List<int>>[];
        var secondNewChromosome = <List<int>>[];

        for (var k = 1; k <= 2; k++) {
          var crossPoints =
              (rnd.nextDouble() * (newPopulation.getChromosomeSize())).toInt();

          var firstPart1 = (newPopulation
                  .getChromosomes()
                  .elementAt(parents.first)
                  .getProperGenes(k)
                  .getRange(0, crossPoints + 1))
              .toList();
          var secondPart1 = (newPopulation
                  .getChromosomes()
                  .elementAt(parents.last)
                  .getProperGenes(k)
                  .getRange(crossPoints + 1, newPopulation.getChromosomeSize()))
              .toList();

          var firstPart2 = (newPopulation
                  .getChromosomes()
                  .elementAt(parents.last)
                  .getProperGenes(k)
                  .getRange(0, crossPoints + 1))
              .toList();
          var secondPart2 = (newPopulation
                  .getChromosomes()
                  .elementAt(parents.first)
                  .getProperGenes(k)
                  .getRange(crossPoints + 1, newPopulation.getChromosomeSize()))
              .toList();

          firstNewChromosome.add([...firstPart1, ...secondPart1]);
          secondNewChromosome.add([...firstPart2, ...secondPart2]);
        }
        newPopulation.addChromosome(
            Chromosome(firstNewChromosome[0], firstNewChromosome[1]));
        newPopulation.addChromosome(
            Chromosome(secondNewChromosome[0], secondNewChromosome[1]));
      }
    }
    if (newPopulation.getChromosomes().length != populationSizeWithoutElite) {
      newPopulation.getChromosomes().removeLast();
      newPopulation
          .setPopulationAmount(newPopulation.getPopulationAmount() - 1);
    }
    return newPopulation;
  }
}

class TwoPointsCross implements Cross {
  var crossProbability;
  var rnd = Random();

  TwoPointsCross(this.crossProbability);

  @override
  Population cross(Population population, int populationSizeWithoutElite) {
    var newPopulation = Population.fromPopulation(
        population.startRange,
        population.endRange,
        population.getPopulationAmount(),
        population.chromosomeSize,
        population.getChromosomes());

    while (newPopulation.getPopulationAmount() < populationSizeWithoutElite) {
      var parents = <int>{};
      do {
        parents.add(
            (rnd.nextDouble() * (newPopulation.getPopulationAmount())).toInt());
      } while (parents.length != 2);

      var crossingChance = rnd.nextDouble();
      if (crossingChance <= crossProbability) {
        var firstNewChromosome = <List<int>>[];
        var secondNewChromosome = <List<int>>[];

        for (var k = 1; k <= 2; k++) {
          var crossPoints = SplayTreeSet();
          do {
            crossPoints.add(
                (rnd.nextDouble() * (newPopulation.getChromosomeSize()))
                    .toInt());
          } while (crossPoints.length != 2);

          var firstPart1 = (newPopulation
                  .getChromosomes()
                  .elementAt(parents.first)
                  .getProperGenes(k)
                  .getRange(0, crossPoints.first + 1))
              .toList();
          var secondPart1 = (newPopulation
                  .getChromosomes()
                  .elementAt(parents.last)
                  .getProperGenes(k)
                  .getRange(crossPoints.first + 1, crossPoints.last + 1))
              .toList();
          var thirdPart1 = (newPopulation
                  .getChromosomes()
                  .elementAt(parents.first)
                  .getProperGenes(k)
                  .getRange(
                      crossPoints.last + 1, newPopulation.getChromosomeSize()))
              .toList();

          var firstPart2 = newPopulation
              .getChromosomes()
              .elementAt(parents.last)
              .getProperGenes(k)
              .getRange(0, crossPoints.first + 1);
          var secondPart2 = newPopulation
              .getChromosomes()
              .elementAt(parents.first)
              .getProperGenes(k)
              .getRange(crossPoints.first + 1, crossPoints.last + 1);
          var thirdPart2 = newPopulation
              .getChromosomes()
              .elementAt(parents.last)
              .getProperGenes(k)
              .getRange(
                  crossPoints.last + 1, newPopulation.getChromosomeSize());

          firstNewChromosome
              .add([...firstPart1, ...secondPart1, ...thirdPart1]);
          secondNewChromosome
              .add([...firstPart2, ...secondPart2, ...thirdPart2]);
        }
        newPopulation.addChromosome(
            Chromosome(firstNewChromosome[0], firstNewChromosome[1]));
        newPopulation.addChromosome(
            Chromosome(secondNewChromosome[0], secondNewChromosome[1]));
      }
    }
    if (newPopulation.getChromosomes().length != populationSizeWithoutElite) {
      newPopulation.getChromosomes().removeLast();
      newPopulation
          .setPopulationAmount(newPopulation.getPopulationAmount() - 1);
    }
    return newPopulation;
  }
}

class ThreePointsCross implements Cross {
  var crossProbability;
  var rnd = Random();

  ThreePointsCross(this.crossProbability);

  @override
  Population cross(Population population, int populationSizeWithoutElite) {
    var newPopulation = Population.fromPopulation(
        population.startRange,
        population.endRange,
        population.getPopulationAmount(),
        population.chromosomeSize,
        population.getChromosomes());

    while (newPopulation.getPopulationAmount() < populationSizeWithoutElite) {
      var parents = <int>{};
      do {
        parents.add(
            (rnd.nextDouble() * (newPopulation.getPopulationAmount())).toInt());
      } while (parents.length != 2);

      var crossingChance = rnd.nextDouble();
      if (crossingChance <= crossProbability) {
        var firstNewChromosome = <List<int>>[];
        var secondNewChromosome = <List<int>>[];

        for (var k = 1; k <= 2; k++) {
          var crossPoints = SplayTreeSet();
          do {
            crossPoints.add(
                (rnd.nextDouble() * (newPopulation.getChromosomeSize()))
                    .toInt());
          } while (crossPoints.length != 3);

          var firstPart1 = (newPopulation
                  .getChromosomes()
                  .elementAt(parents.first)
                  .getProperGenes(k)
                  .getRange(0, crossPoints.first + 1))
              .toList();
          var secondPart1 = (newPopulation
                  .getChromosomes()
                  .elementAt(parents.last)
                  .getProperGenes(k)
                  .getRange(
                      crossPoints.first + 1, crossPoints.elementAt(1) + 1))
              .toList();
          var thirdPart1 = (newPopulation
                  .getChromosomes()
                  .elementAt(parents.first)
                  .getProperGenes(k)
                  .getRange(crossPoints.elementAt(1) + 1, crossPoints.last + 1))
              .toList();
          var fourthPart1 = (newPopulation
                  .getChromosomes()
                  .elementAt(parents.last)
                  .getProperGenes(k)
                  .getRange(
                      crossPoints.last + 1, population.getChromosomeSize()))
              .toList();

          var firstPart2 = (newPopulation
                  .getChromosomes()
                  .elementAt(parents.last)
                  .getProperGenes(k)
                  .getRange(0, crossPoints.first + 1))
              .toList();
          var secondPart2 = (newPopulation
                  .getChromosomes()
                  .elementAt(parents.first)
                  .getProperGenes(k)
                  .getRange(
                      crossPoints.first + 1, crossPoints.elementAt(1) + 1))
              .toList();
          var thirdPart2 = (newPopulation
                  .getChromosomes()
                  .elementAt(parents.last)
                  .getProperGenes(k)
                  .getRange(crossPoints.elementAt(1) + 1, crossPoints.last + 1))
              .toList();
          var fourthPart2 = (newPopulation
                  .getChromosomes()
                  .elementAt(parents.first)
                  .getProperGenes(k)
                  .getRange(
                      crossPoints.last + 1, population.getChromosomeSize()))
              .toList();

          firstNewChromosome.add(
              [...firstPart1, ...secondPart1, ...thirdPart1, ...fourthPart1]);
          secondNewChromosome.add(
              [...firstPart2, ...secondPart2, ...thirdPart2, ...fourthPart2]);
        }
        newPopulation.addChromosome(
            Chromosome(firstNewChromosome[0], firstNewChromosome[1]));
        newPopulation.addChromosome(
            Chromosome(secondNewChromosome[0], secondNewChromosome[1]));
      }
    }
    if (newPopulation.getChromosomes().length != populationSizeWithoutElite) {
      newPopulation.getChromosomes().removeLast();
      newPopulation
          .setPopulationAmount(newPopulation.getPopulationAmount() - 1);
    }
    return newPopulation;
  }
}

class HomogeneousCross implements Cross {
  var crossProbability;
  var rnd = Random();

  HomogeneousCross(this.crossProbability);

  @override
  Population cross(Population population, int populationSizeWithoutElite) {
    var newPopulation = Population.fromPopulation(
        population.startRange,
        population.endRange,
        population.getPopulationAmount(),
        population.chromosomeSize,
        population.getChromosomes());

    while (newPopulation.getPopulationAmount() < populationSizeWithoutElite) {
      var parents = <int>{};
      do {
        parents.add(
            (rnd.nextDouble() * (newPopulation.getPopulationAmount())).toInt());
      } while (parents.length != 2);

      var crossingChance = rnd.nextDouble();
      if (crossingChance <= crossProbability) {
        var firstNewChromosome = <List<int>>[];
        var secondNewChromosome = <List<int>>[];
        for (var k = 1; k <= 2; k++) {
          var firstPart = <int>[];
          var secondPart = <int>[];

          for (var i = 1; i < newPopulation.getChromosomeSize(); i += 2) {
            firstPart.add(newPopulation
                .getChromosomes()
                .elementAt(parents.first)
                .getProperGenes(k)[i - 1]);
            firstPart.add(newPopulation
                .getChromosomes()
                .elementAt(parents.last)
                .getProperGenes(k)[i]);
            secondPart.add(newPopulation
                .getChromosomes()
                .elementAt(parents.first)
                .getProperGenes(k)[i - 1]);
            secondPart.add(newPopulation
                .getChromosomes()
                .elementAt(parents.last)
                .getProperGenes(k)[i]);
          }
          if (population.getChromosomeSize() % 2 != 0) {
            var lastGeneIndex = newPopulation.getChromosomeSize() - 1;
            firstPart.add(newPopulation
                .getChromosomes()
                .elementAt(parents.first)
                .getProperGenes(k)[lastGeneIndex]);
            secondPart.add(newPopulation
                .getChromosomes()
                .elementAt(parents.last)
                .getProperGenes(k)[lastGeneIndex]);
          }

          firstNewChromosome.add(firstPart);
          secondNewChromosome.add(secondPart);
        }
        newPopulation.addChromosome(
            Chromosome(firstNewChromosome[0], firstNewChromosome[1]));
        newPopulation.addChromosome(
            Chromosome(secondNewChromosome[0], secondNewChromosome[1]));
      }
    }
    if (newPopulation.getChromosomes().length != populationSizeWithoutElite) {
      newPopulation.getChromosomes().removeLast();
      newPopulation
          .setPopulationAmount(newPopulation.getPopulationAmount() - 1);
    }
    return newPopulation;
  }
}
