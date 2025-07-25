import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:glowup/Repositories/models/appointment.dart';
part 'p_booking_event.dart';
part 'p_booking_state.dart';

class PBookingBloc extends Bloc<PBookingEvent, PBookingState> {
  final supabase = GetIt.I.get<SupabaseConnect>();
  StreamSubscription<List<Appointment>>? _subscription;
  Map<int, List<Appointment>> appointmentsMap = {};
  double customerRating = 0.0;
  int selectedIndex = 0;

  PBookingBloc() : super(PBookingInitial()) {
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
    add(SubscribeToStreamEvent());
    on<ProviderRatingEvent>((event, emit) async {
      try {
        await supabase.rateCustomer(
          rating: customerRating,
          customerId: event.customerId,
          appointmentId: event.appointmentId,
        );
        emit(ProviderRatingSuccess("Rating submitted successfully!"));
      } catch (e) {
        emit(ProviderRatingError("Error submitting rating: ${e.toString()}"));
      }
    });
    on<PStatusToggleChanged>((event, emit) {
      selectedIndex = event.index;
      emit(StatusToggleChanged());
    });

    on<AcceptAppointmentEvent>((event, emit) async {
      final appointment = event.appointment;
      await supabase.acceptAppointment(appointment.id!);
    });
    on<RejectAppointmentEvent>((event, emit) async {
      final appointment = event.appointment;
      await supabase.rejectAppointment(appointment.id!);
    });
    on<CompleteAppointmentEvent>((event, emit) async {
      try {
        final appointment = event.appointment;
        await supabase.completeAppointment(appointment.id!);
        emit(CompleteAppointmentSuccess("Appointment completed successfully"));
      } catch (e) {
        emit(CompleteAppointmentError("Failed to complete appointment"));
      }
    });
  }
}
