import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/form/form_bloc.dart' as own;

import 'custom_scaffold.dart';
import 'field_bloc_builder.dart';

class FormBlocBuilder extends StatelessWidget {
  final own.FormBloc formBloc;

  FormBlocBuilder(this.formBloc);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: formBloc,
      listener: formListener,
      builder: (context, own.FormState state) {
        return Form(
          child: Column(
            children: [...formFields(), submitButton(state)],
          ),
          autovalidateMode: AutovalidateMode.always,
        );
      },
    );
  }

  List<Widget> formFields() {
    List<Widget> fields = [];

    formBloc.fieldBlocs.forEach((el) {
      fields.add(FieldBlocBuilder.getField(el));
    });

    return fields;
  }

  Widget submitButton(own.FormState state) {
    return TextButton(
      onPressed: () {
        formBloc.add(own.FormSubmitEvent());
      },
      child: state is own.FormSubmitInProgressState
          ? CircularProgressIndicator()
          : Text('Submit'),
    );
  }

  void formListener(BuildContext context, own.FormState state) {
    if (state is own.FormSubmitFailureState) {
      CustomScaffold.simpleShow(context, "Form failure, try again", "Close");
    } else if (state is own.FormSubmitSuccessState) {
      CustomScaffold.simpleShow(context, "Form Success!!!", "See result");
    }
  }
}
