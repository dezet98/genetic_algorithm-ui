import 'package:genetic_algorithms/blocs/abstract/tab_bar/tab_bar_bloc.dart';
import 'package:genetic_algorithms/ui/screens/home/tabs/generate_population_tab.dart';
import 'package:genetic_algorithms/ui/screens/home/tabs/results_tap.dart';

class HomeScreenTabBarBloc extends TabBarBloc {
  HomeScreenTabBarBloc()
      : super(
          [
            GeneratePopulationTab(),
            ResultsTab(),
          ],
          0,
        );
}
