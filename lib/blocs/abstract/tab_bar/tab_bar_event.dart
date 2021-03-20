part of 'tab_bar_bloc.dart';

@immutable
abstract class TabBarEvent {}

class TabBarChangeEvent implements TabBarEvent {
  final int index;

  TabBarChangeEvent(this.index);
}
