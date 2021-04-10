import 'package:genetic_algorithms/blocs/abstract/tab_bar/tab_bar_bloc.dart';
import 'package:genetic_algorithms/ui/screens/home/tabs/generate/generate_population_tab.dart';
import 'package:genetic_algorithms/ui/screens/home/tabs/results/results_tab.dart';

class HomeScreenTabBarBloc extends TabBarBloc {
  HomeScreenTabBarBloc()
      : super(
          [
            GeneratePopulationTab(),
            // if (PlatformInfo.isNotWeb)  TODO
            ResultsTab(),
          ],
          0,
        );
}
