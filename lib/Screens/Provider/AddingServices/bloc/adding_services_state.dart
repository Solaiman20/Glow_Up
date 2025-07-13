part of 'adding_services_bloc.dart';

@immutable
sealed class AddingServicesState {}

final class AddingServicesInitial extends AddingServicesState {}

final class ImageChosenState extends AddingServicesState {}

final class ImagePickingErrorState extends AddingServicesState {
  final String errorMessage;

  ImagePickingErrorState(this.errorMessage);
}

final class ServiceAddedState extends AddingServicesState {}

final class ServiceAddingErrorState extends AddingServicesState {
  final String errorMessage;

  ServiceAddingErrorState(this.errorMessage);
}

final class AtHomeToggleState extends AddingServicesState {
  AtHomeToggleState();
}

final class AStylistChosenState extends AddingServicesState {}

final class UIUpdateState extends AddingServicesState {}
