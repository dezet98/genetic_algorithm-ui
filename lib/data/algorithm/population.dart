import 'dart:core';
import 'dart:math';

import 'chromosome.dart';

class Population {
  static const CHROMOSOME_ACCURACY = 6;
  late double startRange;
  late double endRange;
  late int populationAmount;
  late int chromosomeSize;
  List<Chromosome> chromosomes = [];

  Population(this.startRange, this.endRange, this.populationAmount) {
    chromosomeSize = generateChromosomeSize();
    generateChromosomes();
  }

  Population.empty(this.startRange, this.endRange, this.populationAmount,
      this.chromosomeSize, this.chromosomes);

  Population.fromPopulation(
      this.startRange,
      this.endRange,
      this.populationAmount,
      this.chromosomeSize,
      List<Chromosome> chromosomes) {
    for (var i = 0; i < chromosomes.length; i++) {
      this.chromosomes.add(Chromosome.fromChromosome(
          List.from(chromosomes[i].getFirstGenes()),
          List.from(chromosomes[i].getSecondGenes()),
          chromosomes[i].getGrade()));
    }
  }

  void generateChromosomes() {
    var firstGenes = <int>[];
    var secondGenes = <int>[];
    var rnd = Random();

    for (var i = 0; i < populationAmount; i++) {
      for (var j = 0; j < chromosomeSize; j++) {
        firstGenes.add(rnd.nextInt(2));
        secondGenes.add(rnd.nextInt(2));
      }
      chromosomes.add(Chromosome(firstGenes, secondGenes));
      firstGenes = [];
      secondGenes = [];
    }
  }

  int generateChromosomeSize() {
    var range = (endRange - startRange) * pow(10, CHROMOSOME_ACCURACY);
    return ((log(range) / log(2)) + 1).toInt();
  }

  double decimalFirstNumber(int i) {
    var decimal = startRange +
        int.parse(chromosomes[i].firstGenesToString(), radix: 2) *
            (endRange - startRange) /
            (pow(2, chromosomeSize) - 1);
    return double.parse(decimal.toStringAsFixed(CHROMOSOME_ACCURACY));
  }

  double decimalSecondNumber(int i) {
    var decimal = startRange +
        int.parse(chromosomes[i].secondGenesToString(), radix: 2) *
            (endRange - startRange) /
            (pow(2, chromosomeSize) - 1);
    return double.parse(decimal.toStringAsFixed(CHROMOSOME_ACCURACY));
  }

  int getPopulationAmount() {
    return populationAmount;
  }

  void setPopulationAmount(populationAmounts) {
    populationAmount = populationAmounts;
  }

  int getChromosomeSize() {
    return chromosomeSize;
  }

  List<Chromosome> getChromosomes() {
    return chromosomes;
  }

  void setChromosomes(chromosomes) {
    this.chromosomes = chromosomes;
  }

  void addChromosome(Chromosome chromosome) {
    populationAmount += 1;
    chromosomes.add(chromosome);
  }
}
