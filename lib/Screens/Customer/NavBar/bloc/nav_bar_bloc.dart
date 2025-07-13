import 'package:flutter_bloc/flutter_bloc.dart';

part 'nav_bar_event.dart';
part 'nav_bar_state.dart';


class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {
  NavBarBloc() : super(const NavBarState(0)) {
    on<ChangeTabEvent>((event, emit) {
      emit(NavBarState(event.index));
    });
  }
}



