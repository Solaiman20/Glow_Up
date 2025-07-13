part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class ValidateLogin extends LoginEvent {
  final BuildContext context;
  ValidateLogin({required this.context});
}
