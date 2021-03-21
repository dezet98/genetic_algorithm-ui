import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/field/field_bloc.dart';
import 'package:meta/meta.dart';

part 'form_event.dart';
part 'form_state.dart';

abstract class FormBloc extends Bloc<FormEvent, FormState> {
  late List<FieldBloc> fieldBlocs;

  FormBloc(this.fieldBlocs) : super(FormInitialState());

  void onSubmit();

  @override
  Stream<FormState> mapEventToState(
    FormEvent event,
  ) async* {
    if (event is FormSubmitEvent) {
      yield FormSubmitInProgressState();

      if (!isValid()) {
        yield FormSubmitFailureState();
      } else {
        try {
          onSubmit();
          yield FormSubmitSuccessState();
        } catch (e) {
          yield FormSubmitFailureState();
        }
      }
    }
  }

  bool isValid() {
    for (var i in fieldBlocs) {
      if (i.isInvalid) {
        return false;
      }
    }

    return true;
  }
}
