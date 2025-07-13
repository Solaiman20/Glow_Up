part of 'provider_sign_up_bloc.dart';

@immutable
sealed class ProviderSignUpState {}

final class ProviderSignUpInitial extends ProviderSignUpState {}

class SuccessState extends ProviderSignUpState {}

class ErrorState extends ProviderSignUpState {}

