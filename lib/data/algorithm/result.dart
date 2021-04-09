class Result {
  int epochsAmount;
  int populationSize;
  String algorithmTime;
  List<double> bestInEpoch = [];
  List<double> averageInEpoch = [];
  List<double> standardDeviation = [];

  Result(
      {required this.epochsAmount,
      required this.populationSize,
      required this.algorithmTime,
      required this.bestInEpoch,
      required this.averageInEpoch,
      required this.standardDeviation});
}
