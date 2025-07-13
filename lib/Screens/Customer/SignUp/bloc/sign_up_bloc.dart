import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:glowup/Repositories/layers/location_data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  // List of the text for the "Sign_Up" screen title
  List<String> titleText = ["Get Started", "Choose Location", "Verification"];
  final locationData = GetIt.I.get<LocationData>();
  final supabase = GetIt.I.get<SupabaseConnect>();
  LatLng? position;

  int currentPage = 0;

  // Pageview controller
  PageController pageController = PageController();

  // Form keys for the forms
  final signUpformKey = GlobalKey<FormState>();

  final locationFormKey = GlobalKey<FormState>();

  // Textfields controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) {});

    on<CreateAccountEvent>(createAccountMethod);
    on<SendConfermationEvent>(sendConfermationMethod);
    on<UpdateUIEvent>(updatePageViewMethod);
  }
  @override
  Future<void> close() {
    // Dispose of the controllers when the bloc is closed
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    addressController.dispose();
    pageController.dispose();
    return super.close();
  }

  // Main Validation Method
  FutureOr<void> createAccountMethod(
    CreateAccountEvent event,
    Emitter<SignUpState> emit,
  ) async {
    if (signUpformKey.currentState!.validate()) {
      changePage();
      emit(SuccessState());
    } else {
      emit(ErrorState());
    }
  }

  Future<void> changePage() async {
    log("Previous Page ${pageController.page}");
    if (pageController.page != 2.0) {
      await pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
      );
      currentPage = pageController.page!.toInt();
      log("Current Page $currentPage}");
      return;
    }
    log("You are already on the last page");
  }

  Future<void> updatePageViewMethod(
    UpdateUIEvent event,
    Emitter<SignUpState> emit,
  ) async {
    // Don't forget to add the validation for the textfields
    await changePage();
    emit(SuccessState());
  }

  String? userNameValidation({String? text}) {
    if (text == null || text.isEmpty) {
      return  "This field is required";
    } else if (text.length < 3) {
      return "the name should atleast be 4 charectars long";
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

  String? emailValidation({String? text}) {
    if (text == null || text.isEmpty) {
      return "This field is required";
    } else if (!isEmailValid(text)) {
      return "The email is invalid";
    } else {
      return null;
    }
  }

  bool isPasswordValid(String? password) {
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])').hasMatch(password!);
  }

  String? passwordValidation({String? text}) {
    if (text == null || text.isEmpty) {
      return "This field is required";
    } else if (text.length < 8) {
      return "Password must atleast be 8 Charectars long";
    } else if (!isPasswordValid(text)) {
      return "must contain A Number, An uppercase and a lowercase letter";
    } else {
      return null;
    }
  }

  String? confrimPasswordValidation({String? text}) {
    if (text == null || text.isEmpty) {
      return "This field is required";
    } else if (text != passwordController.text) {
      return "The passwords don't match";
    } else {
      return null;
    }
  }

  FutureOr<void> sendConfermationMethod(
    SendConfermationEvent event,
    Emitter<SignUpState> emit,
  ) async {
    if (locationFormKey.currentState!.validate()) {
      final signUpStatus = await supabase.signUpNewUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        username: nameController.text.trim(),
        position: position!,
      );
      if (signUpStatus) {
        await changePage();
        emit(SuccessState());
      } else {
        emit(ErrorState());
      }
    } else {
      emit(ErrorState());
    }
  }

  String? addressValidation({String? text}) {
    if (text == null || text.isEmpty) {
      return "This field is required";
    } else if (locationData.marker == null) {
      return "Please select a location";
    } else {
      position = locationData.marker!.position;
      locationData.marker = null;
      return null;
    }
  }
}
