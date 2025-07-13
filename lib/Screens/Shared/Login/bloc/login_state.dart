part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class CustomerLoggedIn extends LoginState {}

final class ProviderLoggedIn extends LoginState {}

class SuccessState extends LoginState {}

class ErrorState extends LoginState {
  final String message;

  ErrorState(this.message);
}
