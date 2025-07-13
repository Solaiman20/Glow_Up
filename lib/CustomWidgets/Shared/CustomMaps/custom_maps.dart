import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/CustomWidgets/Shared/CustomMaps/bloc/maps_bloc.dart';
import 'package:glowup/Repositories/layers/location_data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMaps extends StatelessWidget {
  CustomMaps({super.key});
  Set<Marker> markers = {
    GetIt.I.get<LocationData>().marker != null
        ? GetIt.I.get<LocationData>().marker!
        : Marker(markerId: MarkerId('default')),
  };

  @override
  Widget build(BuildContext context) {
    // final myLocation = await _determinePosition();
    // LatLng initialLocation = LatLng(myLocation.latitude, myLocation.longitude);
    return BlocProvider(
      create: (context) => MapsBloc(),
      child: BlocBuilder<MapsBloc, MapsState>(
        builder: (context, state) {
          final bloc = context.read<MapsBloc>();
          Position? initialPosition = bloc.locationData.userLocation;

          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
            height: 150.h,
            width: 323.w,
            child: GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: false,

              initialCameraPosition: CameraPosition(
                target: LatLng(
                  initialPosition.latitude,
                  initialPosition.longitude,
                ),
                zoom: 15,
              ),
              markers: markers,
              onTap: (position) {
                if (!markers.contains(bloc.locationData.marker)) {
                  var marker = Marker(
                    markerId: MarkerId('selectedLocation'),
                    position: LatLng(position.latitude, position.longitude),
                  );
                  markers.add(marker);
                  bloc.locationData.marker = marker;
                } else {
                  markers.clear();
                  var marker = Marker(
                    markerId: MarkerId('selectedLocation'),
                    position: LatLng(position.latitude, position.longitude),
                  );
                  markers.add(marker);
                  bloc.locationData.marker = marker;
                }
                bloc.add(DetermineInitialPosition());
              },
            ),
          );
        },
      ),
    );
  }
}

class CustomMapsBloc {}
