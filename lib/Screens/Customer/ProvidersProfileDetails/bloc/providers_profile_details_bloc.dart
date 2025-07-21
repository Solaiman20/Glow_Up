import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:meta/meta.dart';

part 'providers_profile_details_event.dart';
part 'providers_profile_details_state.dart';

class ProvidersProfileDetailsBloc
    extends Bloc<ProvidersProfileDetailsEvent, ProvidersProfileDetailsState> {
  final supabase = GetIt.I.get<SupabaseConnect>();
  int selectedIndex = 0;
  String selectedCategory = "Hair";
  List<String> categories = ["Hair", "Makeup", "Nails", "Skin", "Other"];
  ProvidersProfileDetailsBloc() : super(ProvidersProfileDetailsInitial()) {
    on<ProvidersProfileDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CategorySelectEvent>((event, emit) {
      selectedIndex = event.index;
      emit(CategorySelectedState());
    });
  }
}
