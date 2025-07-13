import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:glowup/Repositories/models/services.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  TextEditingController searchController = TextEditingController();
  List<Services> searchedServices = [];
  int selectedIndex = 0;
  String selectedCategory = "Hair";
  List<String> categories = ["Hair", "Makeup", "Nails", "Skin", "Other"];
  SupabaseConnect supabaseConnect = GetIt.I<SupabaseConnect>();
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CategorySelectEvent>((event, emit) {
      selectedIndex = event.index;
      emit(CategorySelectedState());
    });
    on<SearchEvent>((event, emit) {
      if (event.query != "") {
        final query = event.query.toLowerCase();
        searchedServices = supabaseConnect.services.where((service) {
          return service.name.toLowerCase().contains(query);
        }).toList();
      } else {
        searchedServices.clear();
      }
      emit(SearchedServicesState());
    });
    on<UpdateUIEvent>((event, emit) {
      emit(UIUpdatedState());
    });
  }
}
