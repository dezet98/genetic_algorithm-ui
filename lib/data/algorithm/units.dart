import 'dart:io';
import 'dart:math';

import 'package:genetic_algorithms/data/algorithm/population.dart';
import 'package:genetic_algorithms/shared/logger/app_logger.dart';
import 'package:genetic_algorithms/shared/platforms.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'grade_strategy.dart';

Future<File> initFile() async {
  String tempName = 'genetic-algorith-results-';

  Directory mainDir = (PlatformInfo.isMobile
      ? await getApplicationDocumentsDirectory()
      : await getDownloadsDirectory())!;

  Directory fileDirectory = await mainDir.createTemp(tempName);

  String path = join(fileDirectory.path, 'each_epoch.txt');

  return File(path);
}

void saveEpochToFile(File file, Population population,
    GradeStrategy gradeStrategy, String epoch) {
  file.writeAsStringSync('Epoch $epoch\n', mode: FileMode.append);
  if (gradeStrategy is MinimalGrade) {
    for (var i = 0; i < population.getPopulationAmount(); i++) {
      file.writeAsStringSync((1 / population.chromosomes[i].grade).toString(),
          mode: FileMode.append);
      file.writeAsStringSync('\n', mode: FileMode.append);
    }
  } else {
    for (var i = 0; i < population.getPopulationAmount(); i++) {
      file.writeAsStringSync(population.chromosomes[i].toString(),
          mode: FileMode.append);
      file.writeAsStringSync('\n', mode: FileMode.append);
    }
  }
  file.writeAsStringSync('\n\n', mode: FileMode.append);
}

void printPopulation(
    Population population, GradeStrategy gradeStrategy, String text) {
  AppLogger().log(message: text, logLevel: LogLevel.info);
  if (gradeStrategy is MinimalGrade) {
    AppLogger().log(
        message: population.chromosomes
            .map((e) => 1 / e.getGrade())
            .toList()
            .toString(),
        logLevel: LogLevel.info);
  } else {
    AppLogger().log(
        message: population.chromosomes.toString(), logLevel: LogLevel.info);
  }
  AppLogger().log(
      message: "${population.getPopulationAmount()}\n ",
      logLevel: LogLevel.info);
}

double findTheBest(
  Population population,
  GradeStrategy gradeStrategy,
) {
  var bestChromosome = population
      .getChromosomes()
      .reduce((curr, next) => curr.getGrade() > next.getGrade() ? curr : next);

  var bestChromosomeGrade;
  if (gradeStrategy is MinimalGrade) {
    bestChromosomeGrade = 1 / bestChromosome.getGrade();
  } else {
    bestChromosomeGrade = bestChromosome.getGrade();
  }

  return bestChromosomeGrade;
}

double calculateAverage(Population population, GradeStrategy gradeStrategy) {
  var sum = 0.0;
  if (gradeStrategy is MinimalGrade) {
    sum = population
        .getChromosomes()
        .map((x) => 1 / x.getGrade())
        .fold(0, (a, b) => a + b);
  } else {
    sum = population
        .getChromosomes()
        .map((x) => x.getGrade())
        .fold(0, (a, b) => a + b);
  }

  return sum / population.getPopulationAmount();
}

double calculateStandardDeviation(
    Population population, GradeStrategy gradeStrategy) {
  var average = 0.0;
  var sum = 0.0;
  if (gradeStrategy is MinimalGrade) {
    average = (population
        .getChromosomes()
        .map((x) => 1 / x.getGrade())
        .fold(0, (a, b) => a + b));

    average /= population.getPopulationAmount();

    for (var i = 0; i < population.getPopulationAmount(); i++) {
      sum += pow((1 / population.getChromosomes()[i].getGrade() - average), 2);
    }
  } else {
    average = (population
        .getChromosomes()
        .map((x) => x.getGrade())
        .fold(0, (a, b) => a + b));

    average /= population.getPopulationAmount();

    for (var i = 0; i < population.getPopulationAmount(); i++) {
      sum += pow((population.getChromosomes()[i].getGrade() - average), 2);
    }
  }

  return sqrt(sum / average);
}
