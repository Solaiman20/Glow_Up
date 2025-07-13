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
