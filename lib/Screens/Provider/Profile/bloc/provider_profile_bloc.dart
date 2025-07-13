import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:glowup/Repositories/models/provider.dart';
import 'package:glowup/Styles/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'provider_profile_event.dart';
part 'provider_profile_state.dart';

class ProviderProfileBloc
    extends Bloc<ProviderProfileEvent, ProviderProfileState> {
  final usernameKey = GlobalKey<FormState>();
  final phoneNumberKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();

  // How to link them with the system
  int languageSwitchValue = 0;
  int themeSwitchValue = 0;

  final supabase = GetIt.I.get<SupabaseConnect>();
  var themeManager = GetIt.I.get<ThemeManager>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Provider provider = GetIt.I.get<SupabaseConnect>().theProvider!;

  // final username = GetIt.I.get<SupabaseConnect>().userProfile.username;

  ProviderProfileBloc() : super(ProviderProfileInitial()) {
    on<ProviderProfileEvent>((event, emit) {});
    on<LanguageSwitchToggleEvent>(updateLanguage);
    on<ThemeSwitchToggleEvent>(updateTheme);
    on<UpdateUIEvent>(updateUI);
    on<UpdateProviderAvatarEvent>(updateAvatarMethod);
    on<LogOutProvider>((event, emit) async {
      emit(ProviderLoggingOut());
      final signOutStatus = await supabase.signOut();
      if (signOutStatus) {
        emit(ProviderLoggedOut());
      } else {
        emit(LogOutError("Failed to log out"));
      }
    });
    on<UpdateProviderBannerEvent>((event, emit) async {
      XFile? pickedBanner = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (pickedBanner != null) {
        final updateStatus = await supabase.uploadProviderBanner(
          localFilePath: pickedBanner.path,
        );

        if (updateStatus!) {
          emit(ProviderBannerSuccessState());
        } else {
          emit(UpdateBannerErrorState("Failed to update banner"));
        }
      }
    });
    on<UpdateProviderUsernameEvent>((event, emit) async {
      final updateStatus = await supabase.updateProviderName(event.username);
      if (updateStatus) {
        emit(UsernameUpdatedState());
      } else {
        emit(UsernameUpdateErrorState("Failed to update username"));
      }
    });
    on<UpdateProviderPhoneEvent>((event, emit) async {
      final updateStatus = await supabase.updateProviderPhone(event.phone);
      if (updateStatus) {
        emit(PhoneNumberUpdatedState());
      } else {
        emit(PhoneNumberUpdateErrorState("Failed to update phone number"));
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

  swtich () {

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
    Emitter<ProviderProfileState> emit,
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
    Emitter<ProviderProfileState> emit,
  ) {
    themeManager.toggleTheme();

    if (themeSwitchValue == 0) {
      print(1);
      themeSwitchValue = 1;
      emit(UpdateState());
    } else {
      print(2);
      themeSwitchValue = 0;
      emit(UpdateState());
    }
  }

  FutureOr<void> updateUI(
    UpdateUIEvent event,
    Emitter<ProviderProfileState> emit,
  ) {
    emit(UpdateState());
  }

  FutureOr<void> updateAvatarMethod(
    event,
    Emitter<ProviderProfileState> emit,
  ) async {
    XFile? pickedAvatar = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedAvatar != null) {
      final updateStatus = await supabase.uploadProviderAvatar(
        localFilePath: pickedAvatar.path,
      );
      if (updateStatus) {
        emit(ProviderAvatarSuccessState());
      } else {
        emit(UpdateAvatarErrorState("Failed to update avatar"));
      }
    }
  }
}
