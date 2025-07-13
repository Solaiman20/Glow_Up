part of 'p_booking_bloc.dart';

abstract class PBookingEvent {}

final class PStatusToggleChanged extends PBookingEvent {
  final int index;
  PStatusToggleChanged(this.index);
}

final class SubscribeToStreamEvent extends PBookingEvent {}

final class AcceptAppointmentEvent extends PBookingEvent {
  final Appointment appointment;
  AcceptAppointmentEvent(this.appointment);
}

final class RejectAppointmentEvent extends PBookingEvent {
  final Appointment appointment;
  RejectAppointmentEvent(this.appointment);
}

final class CompleteAppointmentEvent extends PBookingEvent {
  final Appointment appointment;
  CompleteAppointmentEvent(this.appointment);
}
