import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/shared/logger/simple_bloc_observer.dart';
import 'package:genetic_algorithms/shared/providers.dart';
import 'package:genetic_algorithms/ui/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: getMainBlocProviders(),
//       child: MaterialApp(
//         title: 'Genetic algorithms',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         home: HomeScreen(),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: getMainRepositoryProviders(),
      child: MultiBlocProvider(
        providers: getMainBlocProviders(),
        child: MaterialApp(
          title: 'Genetic algorithms',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomeScreen(),
        ),
      ),
    );
  }
}
