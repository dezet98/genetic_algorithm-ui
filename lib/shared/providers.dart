import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/algorithm_params_form_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/result_delete/result_delete_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/result_save/result_save_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/results/results_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/router/router_bloc.dart';
import 'package:genetic_algorithms/data/services/local_database_service.dart';
import 'package:genetic_algorithms/shared/extensions.dart';
import 'package:genetic_algorithms/shared/local_databases.dart';

List<BlocProvider> getMainBlocProviders() => [
      BlocProvider<RouterBloc>(
        create: (_) => RouterBloc(),
      ),
      BlocProvider<ResultsBloc>(
        create: (context) =>
            ResultsBloc(RepositoryProvider.of<LocalDatabaseService>(context)),
      ),
      BlocProvider<ResultDeleteBloc>(
        create: (context) => ResultDeleteBloc(
          RepositoryProvider.of<LocalDatabaseService>(context),
        ),
      ),
      BlocProvider<ResultSaveBloc>(
        create: (context) => ResultSaveBloc(
          RepositoryProvider.of<LocalDatabaseService>(context),
        ),
      ),
      BlocProvider<AlgorithmParamsFormBloc>(
        create: (context) => AlgorithmParamsFormBloc(
          context.bloc<ResultSaveBloc>(),
        ),
      ),
    ];

List<RepositoryProvider> getMainRepositoryProviders() => [
      RepositoryProvider<LocalDatabaseService>(
        create: (_) => LocalDatabaseService(database1),
      ),
    ];
