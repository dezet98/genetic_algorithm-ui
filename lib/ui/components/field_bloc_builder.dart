import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genetic_algorithms/blocs/abstract/field/field_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/fields/check_field_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/fields/input_field_bloc.dart';
import 'package:genetic_algorithms/blocs/specific_blocs/fields/select_field_bloc.dart';

class FieldBlocBuilder {
  static Widget getField(
      FieldBloc fieldBloc, bool enabled, BuildContext context) {
    if (fieldBloc is InputFieldBloc<String>) {
      return inputFieldString(fieldBloc, enabled);
    } else if (fieldBloc is InputFieldBloc<double>) {
      return inputFieldDouble(fieldBloc, enabled, context);
    } else if (fieldBloc is InputFieldBloc<int>) {
      return inputFieldInt(fieldBloc, enabled, context);
    } else if (fieldBloc is SelectFieldBloc<String>) {
      return selectField(fieldBloc, enabled, context);
    } else if (fieldBloc is CheckFieldBloc) {
      return checkField(fieldBloc, enabled);
    }

    return ElevatedButton(onPressed: null, child: Text('Not implemented'));
  }

  static Widget inputFieldString(InputFieldBloc<String> bloc, bool enabled) {
    return TextFormField(
      initialValue: bloc.value,
      enabled: enabled,
      validator: bloc.validator,
      autovalidateMode: AutovalidateMode.always,
      onChanged: (String value) {
        bloc.add(FieldChangeEvent(value));
      },
      decoration: InputDecoration(
        hintText: bloc.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(),
        ),
      ),
    );
  }

  static Widget inputFieldDouble(
      InputFieldBloc<double> bloc, bool enabled, BuildContext context) {
    return TextFormField(
      initialValue: bloc.value == null ? '' : bloc.value.toString(),
      validator: (String? value) {
        return bloc.validator!(double.tryParse(value!));
      },
      enabled: enabled,
      keyboardType: TextInputType.number,
      //autovalidateMode: AutovalidateMode.disabled,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus();
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"^\d*\.?\d*")),
      ],
      onChanged: (String value) {
        bloc.add(FieldChangeEvent(double.tryParse(value)));
      },
      decoration: InputDecoration(
        labelText: bloc.labelText,
        hintText: bloc.hintText,
        helperText: bloc.helperText,
      ),
    );
  }

  static Widget inputFieldInt(InputFieldBloc<int> bloc, bool enabled, context) {
    return TextFormField(
      initialValue: bloc.value == null ? '' : bloc.value.toString(),
      validator: (String? value) {
        return bloc.validator!(int.tryParse(value!));
      },
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus();
      },
      enabled: enabled,
      keyboardType: TextInputType.number,
      // autovalidateMode: AutovalidateMode.always,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (String value) {
        bloc.add(FieldChangeEvent(int.tryParse(value)));
      },
      decoration: InputDecoration(
        labelText: bloc.labelText,
        hintText: bloc.hintText,
        helperText: bloc.helperText,
      ),
    );
  }

  static Widget selectField(SelectFieldBloc<String> bloc, bool enabled, con) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        return FormField(
          enabled: enabled,
          builder: (state) {
            return DropdownButton<String>(
              value: bloc.value,
              isExpanded: true,
              icon: bloc.icon,
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 1,
                color: Colors.blue,
              ),
              onChanged: enabled
                  ? (String? newValue) {
                      bloc.add(FieldChangeEvent(newValue));
                    }
                  : null,
              items: bloc.items
                  .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(bloc.getName(value)),
                      ))
                  .toList(),
            );
          },
        );
      },
    );
  }

  static Widget checkField(CheckFieldBloc bloc, bool enabled) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        return FormField(
          enabled: enabled,
          builder: (state) {
            return CheckboxListTile(
              value: bloc.value,
              title: Text(bloc.titleText),
              onChanged: enabled
                  ? (bool? newValue) {
                      bloc.add(FieldChangeEvent(newValue));
                    }
                  : null,
            );
          },
        );
      },
    );
  }
}
