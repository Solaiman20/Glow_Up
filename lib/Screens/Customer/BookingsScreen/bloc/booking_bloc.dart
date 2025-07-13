import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:glowup/Repositories/models/appointment.dart';
import 'package:meta/meta.dart';
part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final supabase = GetIt.I.get<SupabaseConnect>();
  Map<int, List<Appointment>> appointmentsMap = {};
  int selectedIndex = 0;

  BookingBloc() : super(BookingInitial()) {
    on<StatusToggleEvent>((event, emit) {
      selectedIndex = event.index;
      emit(StatusToggleChanged());
    });
    on<UpdateUIEvent>((event, emit) {
      emit(UIUpdated());
    });
    on<SubscribeToStreamEvent>((event, emit) async {
      await emit.forEach<List<Appointment>>(
        GetIt.I.get<SupabaseConnect>().watchUserAppointments(),
        onData: (appointments) {
          appointmentsMap = GetIt.I.get<SupabaseConnect>().getUserAppointments(
            appointments,
          );

          return UpdateFromStream();
        },
        onError: (error, stackTrace) => ErrorUpdatingStream(error.toString()),
      );
    });
    on<ServicePayEvent>((event, emit) async {
      try {
        await supabase.payForAppointment(event.appointmentId);
        emit(ServicePaySuccess("Payment successful!"));
      } catch (e) {
        emit(ServicePayError("Error processing payment: ${e.toString()}"));
      }
    });
  }
}
