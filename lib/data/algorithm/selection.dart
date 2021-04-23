import 'dart:math';

import 'chromosome.dart';
import 'population.dart';

abstract class Selection {
  static const BEST = 'best';
  static const ROULETTE = 'roulette';
  static const TOURNAMENT = 'tournament';

  static get items => [BEST, ROULETTE, TOURNAMENT];

  Population selection(Population population);

  static Chromosome getBest(List<Chromosome> chromosomes) {
    chromosomes.sort((a, b) => a.grade.compareTo(b.grade));
    return chromosomes.last;
  }
}

class Best implements Selection {
  var selectionProbability;
  List<Chromosome> bestChromosome = [];

  Best(this.selectionProbability);

  @override
  Population selection(Population population) {
    population.chromosomes.sort((a, b) => b.grade.compareTo(a.grade));

    var selectionElements =
        (population.chromosomes.length * selectionProbability).toInt();

    for (var i = 0; i < selectionElements; i++) {
      bestChromosome.add(population.chromosomes[i]);
    }

    population.chromosomes = bestChromosome;
    population.populationAmount = bestChromosome.length;

    bestChromosome = [];

    return population;
  }
}

class Roulette implements Selection {
  final rand = Random();
  final selectionProbability;

  Roulette(this.selectionProbability);

  @override
  Population selection(Population population) {
    final finalChromosomes = <Chromosome>[];
    var sumOfMatches = 0.0;
    population.chromosomes.forEach((element) {
      sumOfMatches += element.grade;
    });

    var winningProbabilities = List.generate(
      population.chromosomes.length,
      (index) => population.chromosomes[index].grade / sumOfMatches,
    );

    for (var i = 1; i < winningProbabilities.length - 1; i++) {
      winningProbabilities[i] += winningProbabilities[i - 1];
    }
    winningProbabilities.last = 1.0;

    var selectionElements =
        (population.chromosomes.length * selectionProbability).toInt();

    for (var i = 0; i < selectionElements; i++) {
      var random = rand.nextDouble();
      final chromosomeIndexWinner =
          winningProbabilities.indexWhere((el) => el > random);
      finalChromosomes.add(population.chromosomes[chromosomeIndexWinner]);
    }

    population.populationAmount = finalChromosomes.length;
    population.chromosomes = finalChromosomes;
    return population;
  }
}

class Tournament implements Selection {
  final int groupSize;
  final int ladderLength;
  final rand = Random();

  Tournament({this.groupSize = 3, this.ladderLength = 1});

  @override
  Population selection(Population population) {
    var stage = ladderLength;
    var winningChromosomes = List.of(population.chromosomes);

    while (stage-- > 0) {
      winningChromosomes = tournamentStage(winningChromosomes);
    }

    population.populationAmount = winningChromosomes.length;
    population.chromosomes = winningChromosomes;
    return population;
  }

  List<Chromosome> tournamentStage(List<Chromosome> chromosomes) {
    var chromosomesCopy = List.of(chromosomes);
    var stageWinners = <Chromosome>[];
    var rest = chromosomesCopy.length % groupSize;

    while (chromosomesCopy.length > rest) {
      stageWinners.add(Selection.getBest(
        List.generate(
          groupSize,
          (index) =>
              chromosomesCopy.removeAt(rand.nextInt(chromosomesCopy.length)),
        ),
      ));
    }

    stageWinners.addAll(chromosomesCopy);
    return stageWinners;
  }
}
