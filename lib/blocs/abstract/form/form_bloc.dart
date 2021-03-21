import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/field/field_bloc.dart';
import 'package:meta/meta.dart';

part 'form_event.dart';
part 'form_state.dart';

abstract class FormBloc extends Bloc<FormEvent, FormState> {
  late List<FieldBloc> fieldBlocs;

  FormBloc(this.fieldBlocs) : super(FormInitialState());

  Future<void> onSubmit<KeyType>(Map<dynamic, KeyType> values);

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
          await onSubmit(_resultsMap);
          yield FormSubmitSuccessState();
        } catch (e) {
          yield FormSubmitFailureState();
        }
      }
    } else if (event is FormChangeEvent) {
      yield FormChangeState();
    }
  }

  Map<dynamic, dynamic> get _resultsMap {
    Map<dynamic, dynamic> results = {};
    for (var bloc in fieldBlocs) {
      if (bloc.key != null) results.putIfAbsent(bloc.key, () => bloc.value);
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
