import 'package:genetic_algorithms/blocs/abstract/tab_bar/tab_bar_bloc.dart';
import 'package:genetic_algorithms/ui/screens/result_details/charts/charts.dart';
import 'package:genetic_algorithms/ui/screens/result_details/details/details_tab.dart';
import 'package:genetic_algorithms/ui/screens/result_details/info/info.dart';
import 'package:genetic_algorithms/ui/screens/result_details/result_details_screen.dart';

class ResultDetailsTabBarBloc extends TabBarBloc {
  final ResultDetailsScreenArgs args;

  ResultDetailsTabBarBloc({required this.args})
      : super(
          [
            InfoTab(args.algorithmResult),
            ChartsTab(
              averageInEpochs: args.averageInEpochs,
              bestInEpochs: args.bestInEpochs,
              standardDeviations: args.standardDeviations,
            ),
            DetailsTab(
              averageInEpochs: args.averageInEpochs,
              bestInEpochs: args.bestInEpochs,
              standardDeviations: args.standardDeviations,
            ),
          ],
          0,
        );
}
