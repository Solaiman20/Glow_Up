part of 'provider_nav_bar_bloc.dart';

abstract class ProviderNavBarEvent {}

class ChangeProviderTabEvent extends ProviderNavBarEvent {
  final int index;
  ChangeProviderTabEvent(this.index);
}

