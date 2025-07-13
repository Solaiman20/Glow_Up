part of 'booking_details_bloc.dart';

@immutable
sealed class BookingDetailsState {}

final class BookingDetailsInitial extends BookingDetailsState {}

final class StylistSelectedState extends BookingDetailsState {}

final class DateSelectedState extends BookingDetailsState {}

final class TimeSelectedState extends BookingDetailsState {}

final class BookingConfirmedState extends BookingDetailsState {}
