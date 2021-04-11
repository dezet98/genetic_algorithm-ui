import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/field/field_bloc.dart';
import 'package:meta/meta.dart';

part 'form_event.dart';
part 'form_state.dart';

abstract class FormBloc<ResultType> extends Bloc<FormEvent, FormState> {
  late List<FieldBloc> fieldBlocs;

  FormBloc(this.fieldBlocs) : super(FormInitialState());

  Future<ResultType> onSubmit(Map<dynamic, Object?> values);

  @override
  Stream<FormState> mapEventToState(
    FormEvent event,
  ) async* {
    if (event is FormSubmitEvent) {
      yield FormSubmitInProgressState();

      if (isInvalid) {
        yield FormSubmitFailureState();
      } else {
        try {
          ResultType result = await onSubmit(_resultsMap);
          yield FormSubmitSuccessState<ResultType>(result);
        } catch (e) {
          yield FormSubmitFailureState();
        }
      }
    } else if (event is FormChangeEvent) {
      yield FormChangeState();
    }
  }

  Map<dynamic, Object?> get _resultsMap {
    Map<dynamic, Object?> results = {};
    for (var bloc in fieldBlocs) {
      if (bloc.key != null) results.putIfAbsent(bloc.key!, () => bloc.value);
    }

    return results;
  }

  bool get isValid {
    for (var i in fieldBlocs) {
      if (i.isInvalid) {
        return false;
      }
    }

    return true;
  }

  bool get isInvalid {
    for (var i in fieldBlocs) {
      if (i.isInvalid) {
        return true;
      }
    }

    return false;
  }
}
