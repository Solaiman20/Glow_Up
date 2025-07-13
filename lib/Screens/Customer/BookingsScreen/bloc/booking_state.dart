part of 'booking_bloc.dart';

@immutable
sealed class BookingState {}

final class BookingInitial extends BookingState {}

final class StatusToggleChanged extends BookingState {}

final class UIUpdated extends BookingState {}

final class UpdateFromStream extends BookingState {}

final class ErrorUpdatingStream extends BookingState {
  final String errorMessage;

  ErrorUpdatingStream(this.errorMessage);
}

final class ServicePaySuccess extends BookingState {
  final String message;

  ServicePaySuccess(this.message);
}

final class ServicePayError extends BookingState {
  final String errorMessage;

  ServicePayError(this.errorMessage);
}
