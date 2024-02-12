import 'dart:async';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:task_watt/config/app_config.dart';

enum PolylineState { intial, loading, success, failure }

class MainMapController extends GetxController {
  Completer<GoogleMapController> googleMapController = Completer();
  late GoogleMapController mapDefaultController;

  RxMap<String, Marker> markers = <String, Marker>{}.obs;

  final Rx<CameraPosition> _initialCameraPosition = const CameraPosition(
    target: LatLng(25.2043368, 55.2556471),
    zoom: 14.4746,
  ).obs;

  CameraPosition get initialCameraPosition => _initialCameraPosition.value;

  final RxList<LatLng> _polyLineCoordinates = <LatLng>[].obs;
  final Rx<PolylineResult> _polylineResult = PolylineResult().obs;

  final Rx<PolylineState> _polylineState = PolylineState.intial.obs;

  List<LatLng> get polyLineCoordinates => _polyLineCoordinates.value;

  PolylineResult get polylineResult => _polylineResult.value;

  double get totalCost => (_polylineResult.value.distanceValue! / 1000) * 2;

  PolylineState get polylineState => _polylineState.value;

  void animateCameraPosition(CameraPosition newInitialCameraPosition) async {
    mapDefaultController = await googleMapController.future;
    mapDefaultController.animateCamera(CameraUpdate.newCameraPosition(newInitialCameraPosition));
  }

  // To add started marker on map and if the destination is already selected then draw polyline
  void addOriginMarker(LatLng latLng) async {
    final newMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueGreen,
      ),
      markerId: const MarkerId("origin"),
      position: latLng,
    );

    markers['origin'] = newMarker;

    if (markers['destination'] != null) {
      resetOldLocations();
      await getPolylineInformation(markers['origin']!.position, markers['destination']!.position);
    }

    mapDefaultController = await googleMapController.future;
    await mapDefaultController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: latLng,
      zoom: 14.4746,
    )));
  }

  // To add Destination marker on map and if the destination is already selected
  // clean the old locations and add the new marker and draw the polyline
  void addDestinationMarker(LatLng latLng) async {
    final newMarker = Marker(
      markerId: const MarkerId("destination"),
      position: latLng,
    );
    markers['destination'] = newMarker;

    resetOldLocations();

    await getPolylineInformation(markers['origin']!.position, markers['destination']!.position);

    mapDefaultController = await googleMapController.future;
    await mapDefaultController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: latLng,
      zoom: 14.4746,
    )));
  }

  // To animated and track live location for this marker and updated it in map
  void animateLivePositionMarker(LatLng latLng) async {
    final newMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueYellow,
      ),
      markerId: const MarkerId("live-position"),
      position: latLng,
    );

    markers['live-position'] = newMarker;

    mapDefaultController = await googleMapController.future;
    await mapDefaultController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: latLng,
      zoom: 14.4746,
    )));
  }

  // This function to get Polyline Information so we can draw it on the Map
  Future<void> getPolylineInformation(LatLng originLocation, LatLng destinationLocation) async {
    PolylinePoints polylinePoints = PolylinePoints();
    try {
      _polylineState(PolylineState.loading);
      final PolylineResult polylineResult = await polylinePoints.getRouteBetweenCoordinates(
          AppConfig.googleMapKey,
          PointLatLng(
            originLocation.latitude,
            originLocation.longitude,
          ),
          PointLatLng(
            destinationLocation.latitude,
            destinationLocation.longitude,
          ));

      if (polylineResult.points.isNotEmpty) {
        _polylineResult.value = polylineResult;
        for (var point in polylineResult.points) {
          _polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      }
      _polylineState(PolylineState.success);
    } catch (e) {
      _polylineState(PolylineState.failure);
      Get.snackbar("Error", "Un able to fetch route !");
    }
  }

  void resetOldLocations() {
    _polyLineCoordinates([]);
  }
}
