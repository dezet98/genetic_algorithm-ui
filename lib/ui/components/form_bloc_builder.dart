import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/field/field_bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/form/form_bloc.dart' as own;

import 'custom_scaffold.dart';
import 'field_bloc_builder.dart';

class FormBlocBuilder extends StatelessWidget {
  final own.FormBloc formBloc;
  final Widget Function(List<FieldBloc<dynamic>> fieldsBlocs,
      ButtonStyleButton submitButton, bool formEnable)? formBuilder;

  FormBlocBuilder({required this.formBloc, this.formBuilder});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: formBloc,
      listener: _formListener,
      builder: (context, own.FormState state) {
        return Form(
          child: formBuilder != null
              ? formBuilder!(formBloc.fieldBlocs, _submitButton(state),
                  state is own.FormSubmitInProgressState ? false : true)
              : ListView.builder(
                  itemBuilder: (context, index) {
                    if (index == formBloc.fieldBlocs.length) {
                      return _submitButton(state);
                    }
                    return formFieldTile(
                      FieldBlocBuilder.getField(
                          formBloc.fieldBlocs[index],
                          state is own.FormSubmitInProgressState ? false : true,
                          context),
                    );
                  },
                  itemCount: formBloc.fieldBlocs.length + 1,
                ),
          autovalidateMode: AutovalidateMode.always,
          onChanged: () {
            formBloc.add(own.FormChangeEvent());
          },
        );
      },
    );
  }

  ButtonStyleButton _submitButton(own.FormState state) {
    if (state is own.FormSubmitInProgressState) {
      return TextButton(onPressed: () {}, child: CircularProgressIndicator());
    }

    return TextButton(
      onPressed: formBloc.isInvalid
          ? null
          : () {
              formBloc.add(own.FormSubmitEvent());
            },
      child: Text('Submit'),
    );
  }

  static Widget formFieldTile(Widget child) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }

  void _formListener(BuildContext context, own.FormState state) {
    if (state is own.FormSubmitFailureState) {
      CustomScaffold.simpleShow(context, "Form failure, try again", "Close");
    } else if (state is own.FormSubmitSuccessState) {
      CustomScaffold.simpleShow(context, "Form Success!!!", "See result");
    }
  }
}
