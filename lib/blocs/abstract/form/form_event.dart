part of 'form_bloc.dart';

@immutable
abstract class FormEvent {}

class FormSubmitEvent implements FormEvent {}

class FormChangeEvent implements FormEvent {}
