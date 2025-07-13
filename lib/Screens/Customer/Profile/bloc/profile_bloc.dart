import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:glowup/Styles/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final usernameKey = GlobalKey<FormState>();
  final phoneNumberKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final supabase = GetIt.I.get<SupabaseConnect>();
  final themeManager = GetIt.I.get<ThemeManager>();

  int languageSwitchValue = 0;
  int themeSwitchValue = 0;

  bool isDarkMode = false;
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<LanguageSwitchToggleEvent>(updateLanguage);
    on<ThemeSwitchToggleEvent>(updateTheme);
    on<LogOutUser>((event, emit) async {
      emit(UserLoggingOut());
      final signOutStatus = await supabase.signOut();
      if (signOutStatus) {
        emit(UserLoggedOut());
      } else {
        emit(LogOutError("Failed to log out"));
      }
    });
    on<UpdateUserAvatar>((event, emit) async {
      XFile? pickedAvatar = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (pickedAvatar != null) {
        final updateStatus = await supabase.uploadUserAvatar(
          localFilePath: pickedAvatar.path,
          userId: supabase.userProfile!.id,
        );
        if (updateStatus) {
          emit(UserAvatarUpdated());
        } else {
          emit(UpdateAvatarError("Failed to update avatar"));
        }
      }
    });
    on<LoadProfileAvatar>((event, emit) async {
      final avatarUrl = supabase.userProfile?.avatarUrl;
      if (avatarUrl != null) {
        emit(UserAvatarLoaded());
      } else {
        emit(UpdateAvatarError("Failed to load avatar"));
      }
    });
    on<ThemeModeChange>((event, emit) {
      final themeManager = GetIt.I.get<ThemeManager>();
      themeManager.toggleTheme();
      emit(ThemeModeChanged());
    });
    on<UpdateUsernameEvent>((event, emit) async {
      final updateStatus = await supabase.updateUsername(event.username);
      if (updateStatus) {
        emit(UsernameUpdatedState());
      } else {
        emit(UsernameUpdateErrorState("Failed to update username"));
      }
    });
    on<UpdatePhoneEvent>((event, emit) async {
      final updateStatus = await supabase.updatePhone(event.phone);
      if (updateStatus) {
        emit(PhoneNumberUpdatedState());
      } else {
        emit(PhoneNumberUpdateErrorState("Failed to update phone number"));
      }
    });
    on<UpdateEmailEvent>((event, emit) async {
      final updateStatus = await supabase.updateEmail(event.email);
      if (updateStatus) {
        emit(EmailUpdatedState());
      } else {
        emit(EmailUpdateErrorState("Failed to update email"));
      }
    });
  }

  validationMethod(GlobalKey<FormState> validationKey) {
    if (validationKey.currentState!.validate()) {
      emit(SuccessState());
    } else {
      emit(ErrorState());
    }
  }

  String? userNameValidation({String? text}) {
    if (text == null || text.isEmpty) {
      return "This field is required";
    } else if (text.length < 3) {
      return "the name should atleast be 3 charectars long";
    } else {
      return null;
    }
  }

  // The regular Expression for the email  (true = email is valid ---- false = email is invalid)
  bool isEmailValid(String? email) {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(email!);
  }

  // Need to check if the Email already exist
  String? emailValidation({String? text}) {
    if (text == null || text.isEmpty) {
      return "This field is required";
    } else if (!isEmailValid(text)) {
      return "The email is invalid";
    } else {
      return null;
    }
  }

  // Need to check if phone alraedy exist in Supabase
  String? phoneValidation({String? text}) {
    if (text == null || text.isEmpty) {
      return "This field is required";
    } else if (!text.startsWith('05')) {
      return "The number must start with 05";
    } else if (text.length != 10) {
      return "the number you enterd is Inavlid";
    } else {
      return null;
    }
  }

  FutureOr<void> updateLanguage(
    LanguageSwitchToggleEvent event,
    Emitter<ProfileState> emit,
  ) {
    if (languageSwitchValue == 0) {
      languageSwitchValue = 1;
      emit(UpdateLanguageState());
    } else {
      languageSwitchValue = 0;
      emit(UpdateLanguageState());
    }
  }

  FutureOr<void> updateTheme(
    ThemeSwitchToggleEvent event,
    Emitter<ProfileState> emit,
  ) {
    themeManager.toggleTheme();
    if (themeSwitchValue == 0) {
      themeSwitchValue = 1;
      emit(SuccessState());
    } else {
      themeSwitchValue = 0;
      emit(SuccessState());
    }
  }

  FutureOr<void> updateUI(UpdateUIEvent event, Emitter<ProfileState> emit) {
    emit(SuccessState());
  }
}
