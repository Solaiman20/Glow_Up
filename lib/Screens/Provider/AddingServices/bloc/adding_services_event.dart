part of 'adding_services_bloc.dart';

@immutable
sealed class AddingServicesEvent {}

final class ChoosingAnImageEvent extends AddingServicesEvent {}

final class AddingServiceEvent extends AddingServicesEvent {}

final class AtHomeToggleEvent extends AddingServicesEvent {
  final bool isAtHome;

  AtHomeToggleEvent(this.isAtHome);
}

final class ChoosingAStylistEvent extends AddingServicesEvent {}

final class UpdateUIEvent extends AddingServicesEvent {}
