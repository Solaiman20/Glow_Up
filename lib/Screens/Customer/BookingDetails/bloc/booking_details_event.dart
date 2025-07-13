part of 'booking_details_bloc.dart';

@immutable
sealed class BookingDetailsEvent {}

final class ChooseStylistEvent extends BookingDetailsEvent {
  final Stylist stylist;
  ChooseStylistEvent(this.stylist);
}

final class SelectDateEvent extends BookingDetailsEvent {
  final DateTime day;
  final DateTime focusedDay;

  SelectDateEvent(this.day, this.focusedDay);
}

final class SelectTimeEvent extends BookingDetailsEvent {
  final String label;

  SelectTimeEvent(this.label);
}

final class BookAppointmentEvent extends BookingDetailsEvent {
  final Services service;
  final BuildContext context;

  BookAppointmentEvent(this.service, this.context);
}
