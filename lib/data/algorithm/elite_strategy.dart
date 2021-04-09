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
        population.chromosomeSize,
        population.getChromosomes());

    population
        .getChromosomes()
        .sort((a, b) => b.getGrade().compareTo(a.getGrade()));

    for (var i = 0; i < eliteStrategyAmount; i++) {
      eliteChromosome.add(population.getChromosomes()[i]);
    }

    var chromosomes = populationWithoutElite.getChromosomes();

    for (var i = 0; i < eliteChromosome.length; i++) {
      var chromosome = chromosomes.firstWhere(
          (element) => element.getGrade() == eliteChromosome[i].getGrade());
      chromosomes.remove(chromosome);
    }

    populationWithoutElite.setChromosomes(chromosomes);
    populationWithoutElite.setPopulationAmount(chromosomes.length);

    return populationWithoutElite;
  }

  void setBestToPopulation(Population population) {
    var chromosomes = population.getChromosomes();
    for (var i = 0; i < eliteChromosome.length; i++) {
      chromosomes.add(eliteChromosome[i]);
    }
    population.setChromosomes(chromosomes);
    population.setPopulationAmount(
        population.getPopulationAmount() + eliteChromosome.length);
    eliteChromosome = [];
  }
}
