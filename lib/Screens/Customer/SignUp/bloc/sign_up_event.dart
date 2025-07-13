part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}

class CreateAccountEvent extends SignUpEvent{}

class SendConfermationEvent extends SignUpEvent {}

class UpdateUIEvent extends SignUpEvent{}
