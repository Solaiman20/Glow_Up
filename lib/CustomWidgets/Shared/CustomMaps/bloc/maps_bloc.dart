import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/layers/location_data.dart';
import 'package:meta/meta.dart';

part 'maps_event.dart';
part 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  Position? initialPosition;
  final locationData = GetIt.I.get<LocationData>();

  MapsBloc() : super(MapsInitial()) {
    on<MapsEvent>((event, emit) {});
    on<DetermineInitialPosition>((event, emit) async {
      emit(PositionDetermined());
    });
  }
}
