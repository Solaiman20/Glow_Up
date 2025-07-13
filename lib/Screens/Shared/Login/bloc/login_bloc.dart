import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  PageController pageController = PageController();

  final loginFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final supabase = GetIt.I.get<SupabaseConnect>();

  LoginBloc() : super(LoginInitial()) {
    on<ValidateLogin>(loginMethod);
  }

  FutureOr<void> loginMethod(
    ValidateLogin event,
    Emitter<LoginState> emit,
  ) async {
    try {
      if (loginFormKey.currentState!.validate()) {
        final loginStatus = await supabase.signInWithEmail(
          email: emailController.text,
          password: passwordController.text,
        );
        if (loginStatus) {
          if (supabase.userProfile?.role == "customer") {
            emit(CustomerLoggedIn());
          } else if (supabase.userProfile?.role == "provider") {
            emit(ProviderLoggedIn());
          }
        }
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
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

  String? passwordValidation({String? text}) {
    if (text == null || text.isEmpty) {
      return "This field is required";
    } else if (text.length < 8) {
      return "Password must atleast be 8 Charectars long";
    } else {
      return null;
    }
  }
}
