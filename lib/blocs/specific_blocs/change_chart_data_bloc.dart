import 'package:bloc/bloc.dart';

class ChangeChartDataBloc extends Cubit<int> {
  final int lenght;
  final int initialValue;

  ChangeChartDataBloc(this.lenght, this.initialValue) : super(initialValue);

  void next() => emit((state + 1) % lenght);

  void back() => emit((state - 1) % lenght);
}
