import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:task_watt/features/map/controller/address_coordinate_controller.dart';
import 'package:task_watt/features/map/controller/main_map_controller.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({
    required this.addressCoordinateController,
    super.key,
  });

  final AddressCoordinateController addressCoordinateController;

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  // final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  // static const CameraPosition _kLake = CameraPosition(
  //   bearing: 192.8334901395799,
  //   target: LatLng(37.43296265331129, -122.08832357078792),
  //   tilt: 59.440717697143555,
  //   zoom: 19.151926040649414,
  // );

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }

  @override
  Widget build(BuildContext context) {
    return GetX<MainMapController>(
      builder: (mainMapController) {
        return GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          initialCameraPosition: mainMapController.initialCameraPosition,
          markers: Set.from(mainMapController.markers.value.values),
          onTap: (LatLng latLng) async {
            if (mainMapController.polyLineCoordinates.length < 2) {
              mainMapController.addOriginMarker(latLng);
              widget.addressCoordinateController.fetchOriginAddress(latLng);
            }
          },
          polylines: mainMapController.polyLineCoordinates.isEmpty
              ? {}
              : {
                  Polyline(
                    polylineId: const PolylineId('polyline_1'),
                    color: Colors.black,
                    points: mainMapController.polyLineCoordinates,
                    width: 5,
                  ),
                },
          onMapCreated: (GoogleMapController controller) async {
            mainMapController.googleMapController.complete(controller);
            // mapController.mapDefaultController = await mapController.googleMapController.future;
          },
        );
      },
    );
  }
}
