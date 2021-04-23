import 'dart:math';

import 'package:genetic_algorithms/data/algorithm/population.dart';

void printPopulation(String text, Population population) {
  print(text);
  var populationToPrint = [];
  for (var i = 0; i < population.populationAmount; i++) {
    var x = population.chromosomes[i].firstGenes;
    var y = population.chromosomes[i].secondGenes;

    var chromosome = (sin(x + y) + pow((x - y), 2) - 1.5 * x + 2.5 * y + 1);
    populationToPrint.add(chromosome);
  }
  print(populationToPrint);
  print(population.populationAmount);
  print(' ');
}

double findTheBest(Population population) {
  int maxIt = 0;
  double max = population.chromosomes[0].grade;

  for (var i = 0; i < population.populationAmount; i++) {
    if (population.chromosomes[i].grade > max) {
      maxIt = i;
      max = population.chromosomes[i].grade;
    }
  }

  var x = population.chromosomes[maxIt].firstGenes;
  var y = population.chromosomes[maxIt].secondGenes;

  var chromosomeGrade = (sin(x + y) + pow((x - y), 2) - 1.5 * x + 2.5 * y + 1);

  return chromosomeGrade;
}

double calculateAverage(Population population) {
  var sum = 0.0;
  for (var i = 0; i < population.populationAmount; i++) {
    var x = population.chromosomes[i].firstGenes;
    var y = population.chromosomes[i].secondGenes;

    sum += (sin(x + y) + pow((x - y), 2) - 1.5 * x + 2.5 * y + 1);
  }

  return sum / population.populationAmount;
}

double calculateStandardDeviation(Population population) {
  var sum = 0.0;
  for (var i = 0; i < population.populationAmount; i++) {
    var x = population.chromosomes[i].firstGenes;
    var y = population.chromosomes[i].secondGenes;

    sum += (sin(x + y) + pow((x - y), 2) - 1.5 * x + 2.5 * y + 1);
  }

  var average = sum / population.populationAmount;

  var partialSum = 0.0;

  for (var i = 0; i < population.populationAmount; i++) {
    var x = population.chromosomes[i].firstGenes;
    var y = population.chromosomes[i].secondGenes;

    var chromosomeGrade =
        (sin(x + y) + pow((x - y), 2) - 1.5 * x + 2.5 * y + 1);

    partialSum += pow((chromosomeGrade - average), 2);
  }

  return sqrt(partialSum / population.populationAmount);
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
  for (var i = 0; i < population.populationAmount; i++) {
    var x = population.chromosomes[i].firstGenes;
    var y = population.chromosomes[i].secondGenes;

    var chromosome = (sin(x + y) + pow((x - y), 2) - 1.5 * x + 2.5 * y + 1);

    chromosomesGrade.add(chromosome);
  }
  return chromosomesGrade;
}
