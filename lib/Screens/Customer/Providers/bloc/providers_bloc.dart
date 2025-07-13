import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:meta/meta.dart';

part 'providers_event.dart';
part 'providers_state.dart';

class ProvidersBloc extends Bloc<ProvidersEvent, ProvidersState> {
  final supabase = GetIt.I.get<SupabaseConnect>();
  ProvidersBloc() : super(ProvidersInitial()) {
    on<ProvidersEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
