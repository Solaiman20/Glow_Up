part of 'nav_bar_bloc.dart';

abstract class NavBarEvent {}

class ChangeTabEvent extends NavBarEvent {
  final int index;
  ChangeTabEvent(this.index);
}
