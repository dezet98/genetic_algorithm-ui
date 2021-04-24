import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/local_database_get/local_database_get_bloc.dart';
import 'package:genetic_algorithms/shared/exceptions.dart';

class DatabaseGetBuilder extends StatelessWidget {
  final LocalDatabaseGetBloc localDatabaseGetBloc;
  final void Function() refreshAction;
  final Widget Function(BuildContext, LocalDatabaseGetSuccesfullState)
      successBuilder;
  final Widget Function(LocalDatabaseGetInProgressState)? inProgressBuilder;
  final Widget Function(BuildContext, LocalDatabaseGetFailureState)?
      failureBuilder;

  DatabaseGetBuilder(
      {required this.localDatabaseGetBloc,
      required this.refreshAction,
      required this.successBuilder,
      this.failureBuilder,
      this.inProgressBuilder});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: localDatabaseGetBloc,
      builder: resultsBuilder,
      listener: (context, state) {},
    );
  }

  Widget resultsBuilder(BuildContext context, LocalDatabaseGetState state) {
    if (state is LocalDatabaseGetInProgressState) {
      return inProgressBuilder != null
          ? inProgressBuilder!(state)
          : commonInProgressBuilder(state);
    } else if (state is LocalDatabaseGetInitialState) {
      return initialWidget(state);
    } else if (state is LocalDatabaseGetSuccesfullState)
      return successBuilder(context, state);

    return failureBuilder != null
        ? failureBuilder!(context, state as LocalDatabaseGetFailureState)
        : commonFailureBuilder(context, state as LocalDatabaseGetFailureState);
  }

  Widget initialWidget(LocalDatabaseGetInitialState state) {
    return Center(child: CircularProgressIndicator());
  }

  Widget commonInProgressBuilder(LocalDatabaseGetInProgressState state) {
    return Center(child: CircularProgressIndicator());
  }

  Widget commonFailureBuilder(
      BuildContext context, LocalDatabaseGetFailureState state) {
    return Center(
      child: Column(
        children: [
          Text('Error'),
          Text(getTextFromError(state.error)),
          if (state.message != null) Text(state.message!),
          IconButton(
            onPressed: () => refreshAction(),
            icon: Icon(Icons.refresh_rounded),
          ),
        ],
      ),
    );
  }

  static String getTextFromError(LocalDatabaseError error) {
    switch (error) {
      case LocalDatabaseError.UNDEFINED:
        return "UNDEFINED";
      case LocalDatabaseError.GET_FROM_DATABASE_CAST_ERROR:
        return "GET_FROM_DATABASE_CAST_ERROR";
      case LocalDatabaseError.DELETE_ERROR:
        return "DELETE_ERROR";
      default:
        return "UNDEFINED";
    }
  }

  static Widget refreshButton(void Function() refreshAction) {
    return FloatingActionButton(
      heroTag: "refresh",
      child: Icon(Icons.refresh),
      onPressed: () {
        refreshAction();
      },
    );
  }
}
