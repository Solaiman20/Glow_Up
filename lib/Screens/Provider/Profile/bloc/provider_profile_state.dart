part of 'provider_profile_bloc.dart';

@immutable
sealed class ProviderProfileState {}

final class ProviderProfileInitial extends ProviderProfileState {}

class SuccessState extends ProviderProfileState {}

class UpdateState extends ProviderProfileState {}

class ErrorState extends ProviderProfileState {}

final class ProviderAvatarSuccessState extends ProviderProfileState {}

final class UpdateAvatarErrorState extends ProviderProfileState {
  final String message;

  UpdateAvatarErrorState(this.message);
}

final class ProviderBannerSuccessState extends ProviderProfileState {}

final class UpdateBannerErrorState extends ProviderProfileState {
  final String message;

  UpdateBannerErrorState(this.message);
}

final class LogOutError extends ProviderProfileState {
  final String message;

  LogOutError(this.message);
}

final class ProviderLoggedOut extends ProviderProfileState {}

final class ProviderLoggingOut extends ProviderProfileState {}

final class UpdateLanguageState extends ProviderProfileState {}

final class LanguageSwitchToggled extends ProviderProfileState {}

final class UsernameUpdatedState extends ProviderProfileState {}

final class UsernameUpdateErrorState extends ProviderProfileState {
  final String message;

  UsernameUpdateErrorState(this.message);
}

final class PhoneNumberUpdatedState extends ProviderProfileState {}

final class PhoneNumberUpdateErrorState extends ProviderProfileState {
  final String message;

  PhoneNumberUpdateErrorState(this.message);
}

final class EmailUpdatedState extends ProviderProfileState {}

final class EmailUpdateErrorState extends ProviderProfileState {
  final String message;

  EmailUpdateErrorState(this.message);
}
