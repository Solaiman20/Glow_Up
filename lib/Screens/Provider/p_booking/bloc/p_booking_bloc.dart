import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:glowup/Repositories/models/appointment.dart';
part 'p_booking_event.dart';
part 'p_booking_state.dart';

class PBookingBloc extends Bloc<PBookingEvent, PBookingState> {
  final supabae = GetIt.I.get<SupabaseConnect>();
  StreamSubscription<List<Appointment>>? _subscription;
  Map<int, List<Appointment>> appointmentsMap = {};
  int selectedIndex = 0;

  PBookingBloc() : super(PBookingInitial()) {
    on<PStatusToggleChanged>((event, emit) {
      selectedIndex = event.index;
      emit(StatusToggleChanged());
    });
    on<SubscribeToStreamEvent>((event, emit) async {
      await emit.forEach<List<Appointment>>(
        GetIt.I.get<SupabaseConnect>().watchProviderAppointments(),
        onData: (appointments) {
          appointmentsMap = GetIt.I
              .get<SupabaseConnect>()
              .getProviderAppointments(appointments);
          return UpdateFromStream();
        },
        onError: (error, stackTrace) => ErrorUpdatingStream(error.toString()),
      );
    });
    on<AcceptAppointmentEvent>((event, emit) async {
      final appointment = event.appointment;
      await supabae.acceptAppointment(appointment.id!);
    });
    on<RejectAppointmentEvent>((event, emit) async {
      final appointment = event.appointment;
      await supabae.rejectAppointment(appointment.id!);
    });
    on<CompleteAppointmentEvent>((event, emit) async {
      try {
        final appointment = event.appointment;
        await supabae.completeAppointment(appointment.id!);
        emit(CompleteAppointmentSuccess("Appointment completed successfully"));
      } catch (e) {
        emit(CompleteAppointmentError("Failed to complete appointment"));
      }
    });
  }
}
