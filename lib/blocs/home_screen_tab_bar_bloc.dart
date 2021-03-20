import 'package:genetic_algorithms/blocs/abstract/tab_bar/tab_bar_bloc.dart';
import 'package:genetic_algorithms/ui/screens/home/tabs/generate_population_tab.dart';

class HomeScreenTabBarBloc extends TabBarBloc {
  HomeScreenTabBarBloc()
      : super(
          [
            GeneratePopulationTab(),
            GeneratePopulationTab(),
          ],
          0,
        );
}
