import 'chromosome.dart';
import 'population.dart';

class EliteStrategy {
  int eliteStrategyAmount;
  List<Chromosome> eliteChromosome = [];

  EliteStrategy(this.eliteStrategyAmount);

  Population getBestFromPopulation(Population population) {
    var populationWithoutElite = Population.fromPopulation(
        population.startRange,
        population.endRange,
        population.populationAmount,
        population.chromosomes);

    population
        .chromosomes
        .sort((a, b) => b.grade.compareTo(a.grade));

    for (var i = 0; i < eliteStrategyAmount; i++) {
      eliteChromosome.add(population.chromosomes[i]);
    }

    var chromosomes = populationWithoutElite.chromosomes;

    for (var i = 0; i < eliteChromosome.length; i++) {
      var chromosome = chromosomes.firstWhere(
          (element) => element.grade == eliteChromosome[i].grade);
      chromosomes.remove(chromosome);
    }

    populationWithoutElite.chromosomes = chromosomes;
    populationWithoutElite.populationAmount = chromosomes.length;

    return populationWithoutElite;
  }

  void setBestToPopulation(Population population) {
    var chromosomes = population.chromosomes;
    for (var i = 0; i < eliteChromosome.length; i++) {
      chromosomes.add(eliteChromosome[i]);
    }
    population.chromosomes = chromosomes;
    population.populationAmount =
        population.populationAmount + eliteChromosome.length;
    eliteChromosome = [];
  }
}
