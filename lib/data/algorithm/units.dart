import 'dart:io';
import 'dart:math';

import 'package:genetic_algorithms/data/algorithm/population.dart';
import 'package:genetic_algorithms/shared/platforms.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


Future<File> initFile() async {
  String tempName = 'genetic-algorith-results-';

  Directory mainDir = (PlatformInfo.isMobile
      ? await getApplicationDocumentsDirectory()
      : await getDownloadsDirectory())!;

  Directory fileDirectory = await mainDir.createTemp(tempName);

  String path = join(fileDirectory.path, 'each_epoch.txt');

  return File(path);
}

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

void saveEpochToFile(Population population, String epoch, File file) {
  file.writeAsStringSync('Epoch $epoch\n', mode: FileMode.append);

  for (var i = 0; i < population.getPopulationAmount(); i++) {
    var x = population.decimalFirstNumber(i);
    var y = population.decimalSecondNumber(i);

    var chromosome = (sin(x + y) + pow((x - y), 2) - 1.5 * x + 2.5 * y + 1);
    file.writeAsStringSync(chromosome.toString(), mode: FileMode.append);
    file.writeAsStringSync('\n', mode: FileMode.append);
  }

  file.writeAsStringSync('\n\n', mode: FileMode.append);
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

  var chromosomeGrade =
  (sin(x + y) + pow((x - y), 2) - 1.5 * x + 2.5 * y + 1);

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
