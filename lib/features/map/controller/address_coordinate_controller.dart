import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum OriginAddressStatus { idl, loading, success, failure }

enum DestinationAddressStatus { idl, loading, success, failure }

class AddressCoordinateController extends GetxController {
  final _originAddress = ''.obs;

  String get originAddress => _originAddress.value;

  final _originAddressStatus = OriginAddressStatus.idl.obs;

  OriginAddressStatus get originAddressStatus => _originAddressStatus.value;

  final _destinationAddress = ''.obs;

  String get destinationAddress => _destinationAddress.value;

  final _destinationAddressStatus = DestinationAddressStatus.idl.obs;

  DestinationAddressStatus get destinationAddressStatus => _destinationAddressStatus.value;

  // To get String address fom LatLan for started location
  Future<void> fetchOriginAddress(LatLng latLng) async {
    try {
      _originAddressStatus(OriginAddressStatus.loading);
      List<Placemark> placeMarks = await fetchAddressFromCoordinates(latLng);
      _originAddress.value =
          "${placeMarks.first.administrativeArea}, ${placeMarks.first.street} - ${placeMarks.first.subAdministrativeArea} - ${placeMarks.first.locality} ";
      _originAddressStatus(OriginAddressStatus.success);
    } catch (e) {
      _originAddressStatus(OriginAddressStatus.failure);
    }
  }

  // To get String address fom LatLan for destination location
  Future<void> fetchDestinationAddress(LatLng latLng) async {
    try {
      _destinationAddressStatus(DestinationAddressStatus.loading);

      List<Placemark> placeMarks = await fetchAddressFromCoordinates(latLng);

      _destinationAddress.value =
          "${placeMarks.first.administrativeArea}, ${placeMarks.first.street} - ${placeMarks.first.subAdministrativeArea} - ${placeMarks.first.locality} ";
      _destinationAddressStatus(DestinationAddressStatus.success);
    } catch (e) {
      _destinationAddressStatus(DestinationAddressStatus.failure);
    }
  }

  Future<List<Placemark>> fetchAddressFromCoordinates(LatLng latLng) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    log(placeMarks.first.toString());
    return placeMarks;
  }
}
