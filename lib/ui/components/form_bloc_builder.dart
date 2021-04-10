import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/form/form_bloc.dart' as own;

import 'custom_scnack_bar.dart';
import 'field_bloc_builder.dart';

class FormBlocBuilder extends StatelessWidget {
  final own.FormBloc formBloc;
  final Widget Function(own.FormSubmitFailureState state)? buildFailure;
  final Widget Function(own.FormSubmitSuccessState state)? buildSuccess;
  final Widget Function(own.FormSubmitInProgressState state)? buildInProgress;
  final Widget Function(own.FormInitialState state)? buildInitial;
  final Function(BuildContext context, own.FormState state)? listener;

  FormBlocBuilder({
    required this.formBloc,
    this.buildFailure,
    this.buildInProgress,
    this.buildSuccess,
    this.buildInitial,
    this.listener,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: formBloc,
      listener: listener != null ? listener! : _formListener,
      builder: (context, own.FormState state) {
        if (state is own.FormSubmitInProgressState) {
          return (buildInProgress != null)
              ? buildInProgress!(state)
              : commonBuildInProgress();
        } else if (state is own.FormSubmitFailureState) {
          return (buildFailure != null)
              ? buildFailure!(state)
              : commonBuildForm();
        } else if (state is own.FormSubmitSuccessState) {
          return (buildSuccess != null)
              ? buildSuccess!(state)
              : commonBuildForm();
        }

        return (buildInitial != null)
            ? buildInitial!(state as own.FormInitialState)
            : commonBuildForm();
      },
    );
  }

  Widget commonBuildForm() {
    return Form(
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (index == formBloc.fieldBlocs.length) {
            return TextButton(
              onPressed: formBloc.isInvalid
                  ? null
                  : () {
                      formBloc.add(own.FormSubmitEvent());
                    },
              child: Text('Submit'),
            );
          }
          return formFieldTile(
            FieldBlocBuilder.getField(
                formBloc.fieldBlocs[index], true, context),
          );
        },
        itemCount: formBloc.fieldBlocs.length + 1,
      ),
      autovalidateMode: AutovalidateMode.always,
      onChanged: () {
        formBloc.add(own.FormChangeEvent());
      },
    );
  }

  Widget commonBuildInProgress() {
    return Form(
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (index == formBloc.fieldBlocs.length) {
            return TextButton(
              onPressed: () {},
              child: CircularProgressIndicator(),
            );
          }
          return formFieldTile(
            FieldBlocBuilder.getField(
                formBloc.fieldBlocs[index], false, context),
          );
        },
        itemCount: formBloc.fieldBlocs.length + 1,
      ),
      autovalidateMode: AutovalidateMode.always,
      onChanged: () {
        formBloc.add(own.FormChangeEvent());
      },
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
      CustomSnackBar.simpleShow(context, "Form failure, try again", "Close");
    } else if (state is own.FormSubmitSuccessState) {
      CustomSnackBar.simpleShow(context, "Form Success!!!", "Ok");
    }
  }
}
