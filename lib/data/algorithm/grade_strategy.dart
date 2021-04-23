import 'dart:math';

import 'population.dart';

abstract class GradeStrategy {
  static const MAXIMAL_GRADE = 'maximal_grade';
  static const MINIMAL_GRADE = 'minimal_grade';

  void evaluate(Population population);
}

class MaximalGrade implements GradeStrategy {
  @override
  void evaluate(Population population) {
    for (var i = 0; i < population.populationAmount; i++) {
      var x = population.chromosomes[i].firstGenes;
      var y = population.chromosomes[i].secondGenes;

      population
          .chromosomes[i].grade = sin(x + y) + pow((x - y), 2) - 1.5 * x + 2.5 * y + 1;
    }
  }
}

class MinimalGrade implements GradeStrategy {
  @override
  void evaluate(Population population) {
    double min = 1.0;
    for (var i = 0; i < population.populationAmount; i++) {
      var x = population.chromosomes[i].firstGenes;
      var y = population.chromosomes[i].secondGenes;

      population
          .chromosomes[i]
          .grade = (sin(x + y) + pow((x - y), 2) - 1.5 * x + 2.5 * y + 1);

      if (population.chromosomes[i].grade < min) {
        min = population.chromosomes[i].grade;
      }
    }

    if (min <= 0) {
      for (int i = 0; i < population.populationAmount; i++) {
        population.chromosomes[i].grade =
            (population.chromosomes[i].grade - min) + 1;
      }
    }

    for (int i = 0; i < population.populationAmount; i++) {
      population.chromosomes[i].grade = 1 / population.chromosomes[i].grade;
    }
  }
}
