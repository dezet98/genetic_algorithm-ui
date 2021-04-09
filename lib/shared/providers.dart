import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/algorithm_params_form_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/result_delete/result_delete_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/results/results_bloc.dart';
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
      BlocProvider<ResultsBloc>(
        create: (context) =>
            ResultsBloc(RepositoryProvider.of<LocalDatabaseService>(context)),
      ),
      BlocProvider<ResultDeleteBloc>(
        create: (context) => ResultDeleteBloc(
          RepositoryProvider.of<LocalDatabaseService>(context),
        ),
      )
    ];

List<RepositoryProvider> getMainRepositoryProviders() => [
      RepositoryProvider<LocalDatabaseService>(
        create: (_) => LocalDatabaseService(database1),
      ),
    ];
