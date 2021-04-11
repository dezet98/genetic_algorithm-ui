import 'dart:math';

import 'package:genetic_algorithms/data/algorithm/population.dart';

void printPopulation(String text, Population population) {
  print(text);
  var populationToPrint = [];

  for (var i = 0; i < population.getPopulationAmount(); i++) {
    var x = population.decimalFirstNumber(i);
    var y = population.decimalSecondNumber(i);

    var chromosome = (sin(x + y) + pow((x - y), 2) - 1.5 * x + 2.5 * y + 1);
    populationToPrint.add(chromosome);
  }
  print(populationToPrint);
  print(population.getPopulationAmount());
  print(' ');
}

double findTheBest(Population population) {
  int maxIt = 0;
  double max = population.getChromosomes()[0].getGrade();

  for (var i = 0; i < population.getPopulationAmount(); i++) {
    if (population.getChromosomes()[i].getGrade() > max) {
      maxIt = i;
      max = population.getChromosomes()[i].getGrade();
    }
  }

  var x = population.decimalFirstNumber(maxIt);
  var y = population.decimalSecondNumber(maxIt);

  var chromosomeGrade = (sin(x + y) + pow((x - y), 2) - 1.5 * x + 2.5 * y + 1);

  return chromosomeGrade;
}

double calculateAverage(Population population) {
  var sum = 0.0;
  for (var i = 0; i < population.getPopulationAmount(); i++) {
    var x = population.decimalFirstNumber(i);
    var y = population.decimalSecondNumber(i);

    sum += (sin(x + y) + pow((x - y), 2) - 1.5 * x + 2.5 * y + 1);
  }

  return sum / population.getPopulationAmount();
}

double calculateStandardDeviation(Population population) {
  var sum = 0.0;
  for (var i = 0; i < population.getPopulationAmount(); i++) {
    var x = population.decimalFirstNumber(i);
    var y = population.decimalSecondNumber(i);

    sum += (sin(x + y) + pow((x - y), 2) - 1.5 * x + 2.5 * y + 1);
  }

  var average = sum / population.getPopulationAmount();

  var partialSum = 0.0;

  for (var i = 0; i < population.getPopulationAmount(); i++) {
    var x = population.decimalFirstNumber(i);
    var y = population.decimalSecondNumber(i);

    var chromosomeGrade =
        (sin(x + y) + pow((x - y), 2) - 1.5 * x + 2.5 * y + 1);

    partialSum += pow((chromosomeGrade - average), 2);
  }

  return sqrt(partialSum / population.getPopulationAmount());
}

double calculateAverageForBest(List<double> best) {
  var sum = 0.0;
  for (var i = 0; i < best.length; i++) {
    sum += best[i];
  }

  return sum / best.length;
}

List<double> addPopulation(Population population) {
  List<double> chromosomesGrade = [];
  for (var i = 0; i < population.getPopulationAmount(); i++) {
    var x = population.decimalFirstNumber(i);
    var y = population.decimalSecondNumber(i);

    var chromosome = (sin(x + y) + pow((x - y), 2) - 1.5 * x + 2.5 * y + 1);

    chromosomesGrade.add(chromosome);
  }
  return chromosomesGrade;
}
