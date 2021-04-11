import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/local_database_get/local_database_get_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/result/result_details_get_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/router/router_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/tab_bars/result_details_tab_bar_bloc.dart';
import 'package:genetic_algorithms/data/models/algorithm_result.dart';
import 'package:genetic_algorithms/data/models/average_in_epoch.dart';
import 'package:genetic_algorithms/data/models/best_in_epoch.dart';
import 'package:genetic_algorithms/data/models/standard_deviation.dart';
import 'package:genetic_algorithms/data/services/local_database_service.dart';
import 'package:genetic_algorithms/shared/extensions.dart';
import 'package:genetic_algorithms/ui/components/database_get_builder.dart';
import 'package:genetic_algorithms/ui/components/screen_builders.dart';

class ResultDetailsScreenArgs extends RouteArgs {
  final AlgorithmResult algorithmResult;
  final List<BestInEpoch>? bestInEpochs;
  final List<AverageInEpoch>? averageInEpochs;
  final List<StandardDeviation>? standardDeviations;

  ResultDetailsScreenArgs({
    required this.algorithmResult,
    this.bestInEpochs,
    this.averageInEpochs,
    this.standardDeviations,
  });

  bool get isNotNullArgs {
    if (bestInEpochs == null ||
        averageInEpochs == null ||
        standardDeviations == null) {
      return false;
    } else {
      return true;
    }
  }
}

class ResultDetailsScreen extends StatelessWidget {
  final ResultDetailsScreenArgs args;

  ResultDetailsScreen({required this.args});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: args.isNotNullArgs
          ? buildScreen(context, args)
          : loadFromDatabase(context),
    );
  }

  Widget loadFromDatabase(BuildContext context) {
    return DatabaseGetBuilder(
      localDatabaseGetBloc: ResultDetailsGetBloc(
        RepositoryProvider.of<LocalDatabaseService>(context),
        args.algorithmResult.resultId!,
      ),
      successBuilder: successBuilder,
      refreshAction: () => refreshAction(context),
    );
  }

  Widget successBuilder(
      BuildContext context, LocalDatabaseGetSuccesfullState state) {
    ResultDetailsGetBlocData resultDetailsGetData =
        (state as LocalDatabaseGetSuccesfullState<ResultDetailsGetBlocData>)
            .results;
    return buildScreen(
      context,
      ResultDetailsScreenArgs(
        algorithmResult: args.algorithmResult,
        averageInEpochs: resultDetailsGetData.averageInEpochs,
        bestInEpochs: resultDetailsGetData.bestInEpochs,
        standardDeviations: resultDetailsGetData.standardDeviations,
      ),
    );
  }

  Widget buildScreen(
      BuildContext context, ResultDetailsScreenArgs resultDetailsScreenArgs) {
    return ScreenWithBar.top(
      context,
      ResultDetailsTabBarBloc(args: resultDetailsScreenArgs),
      "Result details",
      padding: 0.0,
    );
  }

  void refreshAction(BuildContext context) {
    context.bloc<ResultDetailsGetBloc>().add(LocalDatabaseGetRefreshEvent());
  }
}
