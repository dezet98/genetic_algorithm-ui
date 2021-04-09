import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/algorithm_params_form_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/router/router_bloc.dart';
import 'package:genetic_algorithms/data/services/local_database_service.dart';
import 'package:genetic_algorithms/shared/local_databases.dart';

List<BlocProvider> getMainBlocProviders() => [
      BlocProvider<RouterBloc>(
        create: (_) => RouterBloc(),
      ),
      BlocProvider<AlgorithmParamsFormBloc>(
        create: (_) => AlgorithmParamsFormBloc(),
      ),
    ];

List<RepositoryProvider> getMainRepositoryProviders() => [
      RepositoryProvider<LocalDatabaseService>(
        create: (_) => LocalDatabaseService(database1),
      ),
    ];
