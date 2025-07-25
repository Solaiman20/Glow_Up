part of 'booking_bloc.dart';

@immutable
abstract class BookingEvent {}

final class UpdateUIEvent extends BookingEvent {}

final class StatusToggleEvent extends BookingEvent {
  final int index;
  StatusToggleEvent(this.index);
}

final class SubscribeToStreamEvent extends BookingEvent {}

final class ServicePayEvent extends BookingEvent {
  final int appointmentId;
  ServicePayEvent(this.appointmentId);
}

final class CustomerRatingEvent extends BookingEvent {
  final int appointmentId;
  final String providerId;
  final String stylistId;
  final double stylistRating;
  final double providerRating;
  CustomerRatingEvent({
    required this.appointmentId,
    required this.stylistRating,
    required this.providerRating,
    required this.providerId,
    required this.stylistId,
  });
}
