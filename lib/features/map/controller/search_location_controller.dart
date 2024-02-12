import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:task_watt/features/map/models/route_pridection.dart';
import 'package:task_watt/features/map/repositories/google_map_repository.dart';

class SearchLocationController extends GetxController {
  final GoogleMapRepository _mapRepository = Get.put(GoogleMapRepository());

  final _predictions = <Prediction>[].obs;

  List<Prediction> get predictions => _predictions.value;

  // This function will return the list of predictions places for the entered text,
  void getPredictionPlacesFromSearch(String text) async {
    final predictionResponse = await _mapRepository.getPlacesFromText(text);
    _predictions.value = predictionResponse.predictions;
  }

  // This function will return the LatLan from text Address,
  Future<Location> getLatLanFromAddress(Prediction prediction) async {
    List<Location> locations = await locationFromAddress(prediction.description);
    return locations.first;
  }
}
