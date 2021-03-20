import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BlocExtension on BuildContext {
  T bloc<T extends Bloc>() {
    return BlocProvider.of<T>(this);
  }
}
