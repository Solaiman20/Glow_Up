import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:meta/meta.dart';

part 'add_employee_event.dart';
part 'add_employee_state.dart';

class AddEmployeeBloc extends Bloc<AddEmployeeEvent, AddEmployeeState> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  final supabase = GetIt.I.get<SupabaseConnect>();

  AddEmployeeBloc() : super(AddEmployeeInitial()) {
    on<AddEmployeeEvent>((event, emit) {});
    on<SubmitEvent>(validationMethod);
  }

  FutureOr<void> validationMethod(
    SubmitEvent event,
    Emitter<AddEmployeeState> emit,
  ) async {
    if (formKey.currentState!.validate()) {
      await supabase.addStylist(
        name: nameController.text,
        providerId: supabase.theProvider!.id,
        bio: bioController.text
      );
      emit(SuccessState());
    } else {
      emit(ErrorState());
    }
  }

  String? nameValidation({String? text}) {
    if (text == null || text.isEmpty) {
      return "This field is required";
    } else if (text.length < 3) {
      return "the name should atleast be 4 charectars long";
    } else {
      return null;
    }
  }

  String? bioValidation({String? text}) {
    if (text == null || text.isEmpty) {
      return "This field is required";
    } else if (text.length < 3) {
      return "the bio should atleast be 4 charectars long";
    } else {
      return null;
    }
  }
}
