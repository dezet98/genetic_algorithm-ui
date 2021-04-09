class Chromosome {
  List<int> firstGenes;
  List<int> secondGenes;
  late double grade;

  Chromosome(this.firstGenes, this.secondGenes);

  Chromosome.fromChromosome(this.firstGenes, this.secondGenes, this.grade);

  String firstGenesToString() {
    var genesFirstString = StringBuffer();
    for (var i = 0; i < firstGenes.length; i++) {
      genesFirstString.write(firstGenes[i]);
    }
    return genesFirstString.toString();
  }

  String secondGenesToString() {
    var genesSecondString = StringBuffer();
    for (var i = 0; i < secondGenes.length; i++) {
      genesSecondString.write(secondGenes[i]);
    }
    return genesSecondString.toString();
  }

  List<int> getFirstGenes() {
    return firstGenes;
  }

  List<int> getSecondGenes() {
    return secondGenes;
  }

  List<int> getProperGenes(k) {
    if (k == 1) {
      return firstGenes;
    } else {
      return secondGenes;
    }
  }

  double getGrade() {
    return grade;
  }

  void setGrade(grade) {
    this.grade = grade;
  }

  @override
  String toString() {
    return grade.toString();
  }
}
