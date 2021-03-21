part of 'form_bloc.dart';

@immutable
abstract class FormState {}

class FormInitialState extends FormState {}

class FormSubmitInProgressState extends FormState {}

class FormSubmitSuccessState extends FormState {}

class FormSubmitFailureState extends FormState {}

class FormChangeState extends FormState {}
