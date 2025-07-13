part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class SuccessState extends ProfileState {}

final class ErrorState extends ProfileState {}

final class UserLoggedOut extends ProfileState {}

final class LogOutError extends ProfileState {
  final String message;

  LogOutError(this.message);
}

final class UserLoggingOut extends ProfileState {}

final class UserAvatarUpdated extends ProfileState {}

final class UserAvatarLoaded extends ProfileState {}

final class UpdateAvatarError extends ProfileState {
  final String message;

  UpdateAvatarError(this.message);
}

final class UpdateLanguageState extends ProfileState {}

final class LanguageSwitchToggled extends ProfileState {}

final class ThemeModeChanged extends ProfileState {}

final class UsernameUpdatedState extends ProfileState {}

final class UsernameUpdateErrorState extends ProfileState {
  final String message;

  UsernameUpdateErrorState(this.message);
}

final class PhoneNumberUpdatedState extends ProfileState {}

final class PhoneNumberUpdateErrorState extends ProfileState {
  final String message;
  PhoneNumberUpdateErrorState(this.message);
}

final class EmailUpdatedState extends ProfileState {}

final class EmailUpdateErrorState extends ProfileState {
  final String message;
  EmailUpdateErrorState(this.message);
}
