import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/router/router_bloc.dart';

dynamic getMainBlocProviders() => [
      BlocProvider(
        create: (context) => RouterBloc(),
      ),
    ];
