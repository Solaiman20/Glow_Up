import 'package:flutter_bloc/flutter_bloc.dart';

part 'provider_nav_bar_event.dart';
part 'provider_nav_bar_state.dart';


class ProviderNavBarBloc extends Bloc<ProviderNavBarEvent, ProviderNavBarState> {
  ProviderNavBarBloc() : super(const ProviderNavBarState(0)) {
    on<ChangeProviderTabEvent>((event, emit) {
      emit(ProviderNavBarState(event.index));
    });
  }
}


