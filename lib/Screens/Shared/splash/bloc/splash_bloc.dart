import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<StartTimer>((event, emit) async {
      await Future.delayed(const Duration(seconds: 3));
      emit(SplashFinished());
    });
  }
}

