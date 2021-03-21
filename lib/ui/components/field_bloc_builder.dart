import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/field/field_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/fields/input_field_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/fields/select_field_bloc.dart';

class FieldBlocBuilder {
  static Widget getField(FieldBloc fieldBloc) {
    if (fieldBloc is InputFieldBloc<String>) {
      return inputFieldString(fieldBloc);
    } else if (fieldBloc is InputFieldBloc<double>) {
      return inputFieldDouble(fieldBloc);
    } else if (fieldBloc is InputFieldBloc<int>) {
      return inputFieldInt(fieldBloc);
    } else if (fieldBloc is SelectFieldBloc<String>) {
      return selectField(fieldBloc);
    }

    return ElevatedButton(onPressed: null, child: Text('Not implemented'));
  }

  static Widget inputFieldString(InputFieldBloc<String> bloc) {
    return TextFormField(
      initialValue: bloc.value,
      validator: bloc.validator,
      autovalidateMode: AutovalidateMode.always,
      onChanged: (String value) {
        bloc.add(FieldChangeEvent(value));
      },
    );
  }

  static Widget inputFieldDouble(InputFieldBloc<double> bloc) {
    return TextFormField(
      initialValue: bloc.value.toString(),
      validator: (String? value) {
        return bloc.validator!(double.tryParse(value!));
      },
      keyboardType: TextInputType.number,
      autovalidateMode: AutovalidateMode.always,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'^(-?)(0|([1-9][0-9]*))(\\.[0-9]+)?$')),
      ],
      onChanged: (String value) {
        bloc.add(FieldChangeEvent(double.tryParse(value)));
      },
    );
  }

  static Widget inputFieldInt(InputFieldBloc<int> bloc) {
    return TextFormField(
      initialValue: bloc.value.toString(),
      validator: (String? value) {
        return bloc.validator!(int.tryParse(value!));
      },
      keyboardType: TextInputType.number,
      autovalidateMode: AutovalidateMode.always,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (String value) {
        bloc.add(FieldChangeEvent(int.tryParse(value)));
      },
    );
  }

  static Widget selectField(SelectFieldBloc<String> bloc) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        return FormField(
          builder: (state) {
            return DropdownButton<String>(
              value: bloc.value,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                bloc.add(FieldChangeEvent(newValue));
              },
              items: bloc.items
                  .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
            );
          },
        );
      },
    );
  }
}
