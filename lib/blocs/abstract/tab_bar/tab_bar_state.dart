part of 'tab_bar_bloc.dart';

@immutable
abstract class TabBarState {}

class TabBarInitialState extends TabBarState {}

class TabBarChangeSuccessState extends TabBarState {}

class TabBarChangeInProgressState extends TabBarState {}
