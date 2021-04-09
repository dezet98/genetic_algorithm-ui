import 'package:bloc/bloc.dart';

import 'app_logger.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    String msg =
        "Changing state: '${change.currentState}' -> '${change.nextState}'";
    AppLogger().log(message: msg, logLevel: LogLevel.info);
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    AppLogger().log(message: error.toString(), logLevel: LogLevel.error);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    AppLogger().log(message: event.toString(), logLevel: LogLevel.info);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    String msg =
        "Transition(event: ${transition.event}): '${transition.currentState}' -> '${transition.nextState}'";
    AppLogger().log(message: msg, logLevel: LogLevel.info);
    super.onTransition(bloc, transition);
  }
}
