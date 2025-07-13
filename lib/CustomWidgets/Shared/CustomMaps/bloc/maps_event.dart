part of 'maps_bloc.dart';

@immutable
sealed class MapsEvent {}

final class DetermineInitialPosition extends MapsEvent {
  DetermineInitialPosition();
}
