part of 'provider_sign_up_bloc.dart';

@immutable
sealed class ProviderSignUpEvent {}

class CreateProviderAccountEvent extends ProviderSignUpEvent {}

class SendConfermationEvent extends ProviderSignUpEvent {}

class UpdateUIEvent extends ProviderSignUpEvent {}





