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
    double min = 1.0;
    for (var i = 0; i < population.getPopulationAmount(); i++) {
      var x = population.decimalFirstNumber(i);
      var y = population.decimalSecondNumber(i);

      population
          .getChromosomes()[i]
          .setGrade((sin(x + y) + pow((x - y), 2) - 1.5 * x + 2.5 * y + 1));

      if (population.getChromosomes()[i].getGrade() < min) {
        min = population.getChromosomes()[i].getGrade();
      }
    }

    if (min <= 0) {
      for (int i = 0; i < population.getPopulationAmount(); i++) {
        population.getChromosomes()[i].setGrade(
            (population.getChromosomes()[i].getGrade() - min) + 1);
      }
    }

    for (int i = 0; i < population.getPopulationAmount(); i++) {
      population.getChromosomes()[i].setGrade(
          1 / population.getChromosomes()[i].getGrade());
    }
  }
}
