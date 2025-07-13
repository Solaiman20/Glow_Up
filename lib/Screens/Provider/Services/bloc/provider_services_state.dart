part of 'provider_services_bloc.dart';

@immutable
sealed class ProviderServicesState {}

final class ProviderServicesInitial extends ProviderServicesState {}

final class ServiceDeletedState extends ProviderServicesState {}

final class ServiceDeletionErrorState extends ProviderServicesState {
  final String errorMessage;

  ServiceDeletionErrorState(this.errorMessage);
}

final class UIUpdateState extends ProviderServicesState {}
