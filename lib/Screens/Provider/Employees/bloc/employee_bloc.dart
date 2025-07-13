import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:glowup/Repositories/models/provider.dart';
import 'package:meta/meta.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  Provider provider = GetIt.I.get<SupabaseConnect>().theProvider!;
  EmployeeBloc() : super(EmployeeInitial()) {
    on<EmployeeEvent>((event, emit) {});
  }
}
