import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:task_watt/features/map/controller/main_map_controller.dart';
import 'package:task_watt/utils/get_location_permession_helper.dart';

import '../controller/address_coordinate_controller.dart';

class SelectLocationFromMapView extends StatefulWidget {
  const SelectLocationFromMapView({
    this.isOriginDestination = false,
    super.key,
  });

  final bool isOriginDestination;

  @override
  State<SelectLocationFromMapView> createState() => _SelectLocationFromMapViewState();
}

class _SelectLocationFromMapViewState extends State<SelectLocationFromMapView> {
  Completer<GoogleMapController> googleMapController = Completer<GoogleMapController>();
  final AddressCoordinateController addressCoordinateController = Get.find();
  final MainMapController mainMapController = Get.find();

  Marker? _currentMarker;

  CameraPosition? _initialCameraPosition = const CameraPosition(
    target: LatLng(25.2043368, 55.2556471),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    requesteLocationPermissionAndGetLocation()?.then((myLocation) async {
      final newInitialCameraPosition = CameraPosition(
        target: LatLng(myLocation.latitude, myLocation.longitude),
        zoom: 14.4746,
      );

      _initialCameraPosition = newInitialCameraPosition;

      _currentMarker = Marker(
        markerId: const MarkerId('selected-location'),
        position: LatLng(myLocation.latitude, myLocation.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
          title: 'Selected Location',
          // snippet: 'Lat: ${latLng.latitude}, Lng: ${latLng.longitude}',
        ),
      );
      GoogleMapController mapDefaultController = await googleMapController.future;
      mapDefaultController.animateCamera(CameraUpdate.newCameraPosition(newInitialCameraPosition));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: FilledButton.tonal(
              onPressed: () {
                Get.back();
                Get.back();
                if (_currentMarker != null) {
                  if (widget.isOriginDestination) {
                    addressCoordinateController.fetchOriginAddress(_currentMarker!.position);
                    mainMapController.addOriginMarker(_currentMarker!.position);
                  } else {
                    addressCoordinateController.fetchDestinationAddress(_currentMarker!.position);
                    mainMapController.addDestinationMarker(_currentMarker!.position);
                  }
                }
              },
              child: Row(
                children: [
                  Text(
                    "OK",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black87),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.save,
                    size: 20,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: Platform.isIOS ? 15 : 0.0),
        child: GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          initialCameraPosition: _initialCameraPosition!,
          markers: _currentMarker != null ? {_currentMarker!} : {},
          onTap: (LatLng latLng) {
            setState(() {
              _currentMarker = Marker(
                markerId: const MarkerId('selected-location'),
                position: latLng,
                icon: BitmapDescriptor.defaultMarker,
                infoWindow: InfoWindow(
                  title: 'Selected Location',
                  snippet: 'Lat: ${latLng.latitude}, Lng: ${latLng.longitude}',
                ),
              );
            });
          },
          // onCameraMove: (CameraPosition cameraPosition) {
          //   log("Camera position: ${cameraPosition.target} ");
          //   _updateMarker(cameraPosition.target);
          // },
          onMapCreated: (GoogleMapController controller) async {
            googleMapController.complete(controller);
            GoogleMapController mapDefaultController = await googleMapController.future;
            mapDefaultController.animateCamera(
              CameraUpdate.newCameraPosition(_initialCameraPosition!),
            );
          },
        ),
      ),
    );
  }

// void _updateMarker(LatLng position) {
//   setState(() {
//     _currentCameraPosition = position;
//     _currentMarker = Marker(
//       markerId: const MarkerId('selected-location'),
//       position: position,
//       icon: BitmapDescriptor.defaultMarker,
//       infoWindow: InfoWindow(
//         title: 'Selected Location',
//         snippet: 'Lat: ${position.latitude}, Lng: ${position.longitude}',
//       ),
//     );
//   });
// }
}
