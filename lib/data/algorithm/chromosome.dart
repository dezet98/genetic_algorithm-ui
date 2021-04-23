import 'dart:math';

class Chromosome {
  double firstGenes;
  double secondGenes;
  late double grade;

  Chromosome(this.firstGenes, this.secondGenes);

  Chromosome.fromChromosome(this.firstGenes, this.secondGenes, this.grade);

  Chromosome.withEvaluate(this.firstGenes, this.secondGenes) {
    this.grade = (sin(this.firstGenes + this.secondGenes) +
        pow((this.firstGenes - this.secondGenes), 2) -
        1.5 * this.firstGenes +
        2.5 * this.secondGenes +
        1);
  }

  double getProperGenes(k) {
    if (k == 1) {
      return firstGenes;
    } else {
      return secondGenes;
    }
  }

  void setProperGenes(gene, k) {
    if (k == 1) {
      this.firstGenes = gene;
    } else {
      this.secondGenes = gene;
    }
  }

  @override
  String toString() {
    return firstGenes.toString();
  }
}
