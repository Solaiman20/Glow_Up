part of 'provider_profile_bloc.dart';

@immutable
sealed class ProviderProfileEvent {}

class SubmitChange extends ProviderProfileEvent {}

final class LanguageSwitchToggleEvent extends ProviderProfileEvent {}

final class ThemeSwitchToggleEvent extends ProviderProfileEvent {}

final class UpdateProviderAvatarEvent extends ProviderProfileEvent {}

final class UpdateUIEvent extends ProviderProfileEvent {}

final class LogOutProvider extends ProviderProfileEvent {}

final class UpdateProviderBannerEvent extends ProviderProfileEvent {}

final class UpdateProviderUsernameEvent extends ProviderProfileEvent {
  final String username;

  UpdateProviderUsernameEvent(this.username);
}

final class UpdateProviderPhoneEvent extends ProviderProfileEvent {
  final String phone;

  UpdateProviderPhoneEvent(this.phone);
}

final class UpdateProviderEmailEvent extends ProviderProfileEvent {
  final String email;

  UpdateProviderEmailEvent(this.email);
}
