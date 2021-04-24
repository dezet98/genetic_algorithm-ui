import 'dart:math';

import 'population.dart';

abstract class Mutation {
  static const UNIFORM_MUTATION = 'uniform_mutation';

  static get items => [UNIFORM_MUTATION];

  static String text(String code) {
    switch (code) {
      case UNIFORM_MUTATION:
        return "Uniform mutation";
      default:
        return "-";
    }
  }

  static String shortText(String code) {
    switch (code) {
      case UNIFORM_MUTATION:
        return "Un";
      default:
        return "-";
    }
  }

  Population mutation(Population population);
}

class UniformMutation implements Mutation {
  var mutationProbability;
  var rnd = Random();

  UniformMutation(this.mutationProbability);

  @override
  Population mutation(Population population) {
    for (int i = 0; i < population.populationAmount; i++) {
      double mutationChance = rnd.nextDouble();
      if (mutationChance <= mutationProbability) {
        int mutatedElement = rnd.nextInt(2);
        double genes = double.parse(((rnd.nextDouble() *
                    (population.endRange - population.startRange)) +
                population.startRange)
            .toStringAsFixed(Population.CHROMOSOME_ACCURACY));
        if (mutatedElement == 0) {
          population.chromosomes[i].firstGenes = genes;
        } else {
          population.chromosomes[i].secondGenes = genes;
        }
      }
    }
    return population;
  }
}
