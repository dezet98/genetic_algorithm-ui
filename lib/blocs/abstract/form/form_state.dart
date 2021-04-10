part of 'form_bloc.dart';

@immutable
abstract class FormState {}

class FormInitialState extends FormState {}

class FormSubmitInProgressState extends FormState {}

class FormSubmitSuccessState<ResultType> extends FormState {
  final ResultType result;

  FormSubmitSuccessState(this.result);
}

class FormSubmitFailureState extends FormState {}

class FormChangeState extends FormState {}
