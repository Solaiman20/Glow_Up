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
  final Services service;

  SelectDateEvent(this.day, this.focusedDay, this.service);
}

final class SelectTimeEvent extends BookingDetailsEvent {
  final DateTime selectedTime;

  SelectTimeEvent(this.selectedTime);
}

final class BookAppointmentEvent extends BookingDetailsEvent {
  final Services service;
  final BuildContext context;

  BookAppointmentEvent(this.service, this.context);
}
