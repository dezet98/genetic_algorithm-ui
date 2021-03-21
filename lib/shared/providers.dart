import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/algorithm_params_form_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/router/router_bloc.dart';

List<BlocProvider> getMainBlocProviders() => [
      BlocProvider<RouterBloc>(
        create: (_) => RouterBloc(),
      ),
      BlocProvider<AlgorithmParamsFormBloc>(
        create: (_) => AlgorithmParamsFormBloc(),
      ),
    ];
