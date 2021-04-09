import 'dart:collection';
import 'dart:math';

import 'population.dart';

class Inversion {
  double inversionProbability;
  final rand = Random();

  Inversion(this.inversionProbability);

  Population inversion(Population population) {
    for (var i = 0; i < population.getPopulationAmount(); i++) {
      for (var k = 0; k < 2; k++) {
        var inversionChance = rand.nextDouble();
        if (inversionChance <= inversionProbability) {
          var mutationPoints = SplayTreeSet();
          do {
            mutationPoints.add(
                (rand.nextDouble() * (population.getChromosomeSize())).toInt());
          } while (mutationPoints.length != 2);
          var chromosomes = population.getChromosomes();
          var listGene = chromosomes[i].getProperGenes(k);

          var middleSection =
              listGene.sublist(mutationPoints.first, mutationPoints.last + 1);
          listGene.setRange(mutationPoints.first, mutationPoints.last + 1,
              middleSection.reversed);

          population.setChromosomes(chromosomes);
        }
      }
    }

    return population;
  }
}
