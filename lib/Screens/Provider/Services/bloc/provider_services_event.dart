part of 'provider_services_bloc.dart';

@immutable
sealed class ProviderServicesEvent {}

final class DeleteServiceEvent extends ProviderServicesEvent {
  final int serviceId;

  DeleteServiceEvent({required this.serviceId});
}

final class UpdateUIEvent extends ProviderServicesEvent {}
