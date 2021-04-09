import 'dart:math';

import 'population.dart';

abstract class GradeStrategy {
  static const MAXIMAL_GRADE = 'maximal_grade';
  static const MINIMAL_GRADE = 'minimal_grade';

  void evaluate(Population population);
}

// population.getChromosomes()[i].setGrade(1 /
// (pow(population.decimalFirstNumber(i), 2) +
// pow(population.decimalSecondNumber(i), 2)));
class MaximalGrade implements GradeStrategy {
  @override
  void evaluate(Population population) {
    for (var i = 0; i < population.getPopulationAmount(); i++) {
      var x = population.decimalFirstNumber(i);
      var y = population.decimalSecondNumber(i);

      population
          .getChromosomes()[i]
          .setGrade(sin(x + y) + pow((x - y), 2) - 1.5 * x + 2.5 * y + 1);
    }
  }
}

class MinimalGrade implements GradeStrategy {
  @override
  void evaluate(Population population) {
    for (var i = 0; i < population.getPopulationAmount(); i++) {
      var x = population.decimalFirstNumber(i);
      var y = population.decimalSecondNumber(i);

      population
          .getChromosomes()[i]
          .setGrade(1/(sin(x + y) + pow((x - y), 2) - 1.5 * x + 2.5 * y + 1));
    }
  }
}
