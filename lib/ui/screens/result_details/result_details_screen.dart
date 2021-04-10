import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/router/router_bloc.dart';
import 'package:genetic_algorithms/data/models/algorithm_result.dart';
import 'package:genetic_algorithms/data/models/average_in_epoch.dart';
import 'package:genetic_algorithms/data/models/best_in_epoch.dart';
import 'package:genetic_algorithms/data/models/standard_deviation.dart';

class ResultDetailsScreenArgs extends RouteArgs {
  final AlgorithmResult algorithmResult;
  final List<BestInEpoch>? bestInEpochs;
  final List<AverageInEpoch>? averageInEpochs;
  final List<StandardDeviation>? standardDeviations;

  ResultDetailsScreenArgs(
      {required this.algorithmResult,
      this.bestInEpochs,
      this.averageInEpochs,
      this.standardDeviations});
}

class ResultDetailsScreen extends StatelessWidget {
  final ResultDetailsScreenArgs args;

  ResultDetailsScreen({required this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Result Details",
        ),
      ),
    );
  }
}
