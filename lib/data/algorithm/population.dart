import 'dart:core';
import 'dart:math';

import 'chromosome.dart';

class Population {
  static const CHROMOSOME_ACCURACY = 6;
  late double startRange;
  late double endRange;
  late int populationAmount;
  List<Chromosome> chromosomes = [];

  Population(this.startRange, this.endRange, this.populationAmount) {
    generateChromosomes();
  }

  Population.empty(
      this.startRange, this.endRange, this.populationAmount, this.chromosomes);

  Population.fromPopulation(this.startRange, this.endRange,
      this.populationAmount, List<Chromosome> chromosomes) {
    for (var i = 0; i < chromosomes.length; i++) {
      this.chromosomes.add(Chromosome.fromChromosome(chromosomes[i].firstGenes,
          chromosomes[i].secondGenes, chromosomes[i].grade));
    }
  }

  void generateChromosomes() {
    var genes = <double>[];
    var rnd = Random();

    for (var i = 0; i < populationAmount; i++) {
      for (var j = 0; j < 2; j++) {
        double gene = double.parse(
            ((rnd.nextDouble() * (endRange - startRange)) + startRange)
                .toStringAsFixed(CHROMOSOME_ACCURACY));
        genes.add(gene);
      }
      chromosomes.add(Chromosome(genes[0], genes[1]));
      genes = [];
    }
  }

  void addChromosome(Chromosome chromosome) {
    populationAmount += 1;
    chromosomes.add(chromosome);
  }
}
