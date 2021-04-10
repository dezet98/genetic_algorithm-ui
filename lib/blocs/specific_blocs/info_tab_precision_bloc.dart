import 'package:bloc/bloc.dart';

class InfoTabPrecisionBloc extends Cubit<int> {
  InfoTabPrecisionBloc() : super(2);

  void increment() => (state < 10) ? emit(state + 1) : emit(10);

  void decrement() => (state > 1) ? emit(state - 1) : emit(0);
}
