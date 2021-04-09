import 'dart:collection';
import 'dart:math';
import 'population.dart';

abstract class Mutation {
  static const ONE_POINT_MUTATION = 'one_point_mutation';
  static const TWO_POINTS_MUTATION = 'two_points_mutation';
  static const EDGE_MUTATION = 'edge_mutation';

  Population mutation(Population population);
}

class OnePointMutation implements Mutation {
  var mutationProbability;
  var rnd = Random();

  OnePointMutation(this.mutationProbability);

  @override
  Population mutation(Population population) {
    for (var i = 0; i < population.getPopulationAmount(); i++) {
      for (var k = 0; k < 2; k++) {
        var mutationChance = rnd.nextDouble();
        if (mutationChance <= mutationProbability) {
          var mutationPoint =
              (rnd.nextDouble() * population.getChromosomeSize()).toInt();

          var chromosomes = population.getChromosomes();
          var listGene = chromosomes.elementAt(i).getProperGenes(k);

          var setBit;
          if (listGene[mutationPoint] == 1) {
            setBit = 0;
          } else {
            setBit = 1;
          }

          if (listGene[mutationPoint] == 0) {
            setBit = 1;
          } else {
            setBit = 0;
          }

          listGene[mutationPoint] = setBit;
          population.setChromosomes(chromosomes);
        }
      }
    }
    return population;
  }
}

class TwoPointsMutation implements Mutation {
  var mutationProbability;
  var rnd = Random();

  TwoPointsMutation(this.mutationProbability);

  @override
  Population mutation(Population population) {
    for (var i = 0; i < population.getPopulationAmount(); i++) {
      for (var k = 0; k < 2; k++) {
        var mutationChance = rnd.nextDouble();
        if (mutationChance <= mutationProbability) {
          var mutationPoints = SplayTreeSet();
          do {
            mutationPoints.add(
                (rnd.nextDouble() * (population.getChromosomeSize())).toInt());
          } while (mutationPoints.length != 2);

          for (var z = 0; z < 2; z++) {
            var chromosomes = population.getChromosomes();
            var listGene = chromosomes.elementAt(i).getProperGenes(k);

            var setBit;
            if (listGene[mutationPoints.elementAt(z)] == 1) {
              setBit = 0;
            } else {
              setBit = 1;
            }

            if (listGene[mutationPoints.elementAt(z)] == 0) {
              setBit = 1;
            } else {
              setBit = 0;
            }

            listGene[mutationPoints.elementAt(z)] = setBit;
            population.setChromosomes(chromosomes);
          }
        }
      }
    }
    return population;
  }
}

class EdgeMutation implements Mutation {
  var mutationProbability;
  var rnd = Random();

  EdgeMutation(this.mutationProbability);

  @override
  Population mutation(Population population) {
    for (var i = 0; i < population.getPopulationAmount(); i++) {
      for (var k = 0; k < 2; k++) {
        var mutationChance = rnd.nextDouble();
        if (mutationChance <= mutationProbability) {
          var chromosomes = population.getChromosomes();
          var listGene = chromosomes.elementAt(i).getProperGenes(k);

          var setBit;
          if (listGene[population.getChromosomeSize() - 1] == 1) {
            setBit = 0;
          } else {
            setBit = 1;
          }

          if (listGene[population.getChromosomeSize() - 1] == 0) {
            setBit = 1;
          } else {
            setBit = 0;
          }

          listGene[population.getChromosomeSize() - 1] = setBit;
          population.setChromosomes(chromosomes);
        }
      }
    }
    return population;
  }
}
