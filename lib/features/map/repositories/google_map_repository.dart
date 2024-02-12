import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:task_watt/config/app_config.dart';
import 'package:task_watt/core/api/dio_client.dart';
import 'package:task_watt/core/api/network_result.dart';
import 'package:task_watt/features/map/models/direction.dart';
import 'package:task_watt/features/map/models/route_pridection.dart';

class GoogleMapRepository {
  final DioClient _dio = Get.put(DioClient());

  Future<RoutePredictionResponse> getPlacesFromText(String text) async {
    try {
      final networkResult =
          await _dio.get("maps/api/place/autocomplete/json?input=$text&key=${AppConfig.googleMapKey}");

      late RoutePredictionResponse predictionResponse;
      if (networkResult is NetworkResultSuccess) {
        predictionResponse = RoutePredictionResponse.fromJson(networkResult.data!);
      }
      return predictionResponse;
    } catch (e) {
      rethrow;
    }
  }

// Future<Map<String, dynamic>> fetchAddress(LatLng latLng) async {
//   final addressUrl =
//       "https://maps.googleapis.com/maps/api/geocode/json?address=${latLng.latitude},${latLng.longitude}&key=${AppConfig.googleMapKey}";
//   try {
//     final response = await _dio.get(addressUrl);
//
//     final loadedAddress = jsonDecode(jsonEncode(response.data)) as dynamic;
//
//     return {"dd": "address"};
//   } catch (e) {
//     throw e.toString();
//   }
// }

  // To Draw Polyline from Url
  Future<Directions> getDirection(LatLng originLocation, LatLng selectedLocation) async {
    const String _directionsUrl = 'https://maps.googleapis.com/maps/api/directions/json?';

    try {
      final networkResult = await _dio.get(_directionsUrl, queryParameters: {
        "origin": '${originLocation.latitude},${originLocation.longitude}',
        "destination": '${selectedLocation.latitude},${selectedLocation.longitude}',
        "key": AppConfig.googleMapKey,
      });

      late Directions directions;
      if (networkResult is NetworkResultSuccess) {
        directions = Directions.fromMap(networkResult.data);
      }

      return directions;
    } catch (e) {
      throw e.toString();
    }
  }
}
