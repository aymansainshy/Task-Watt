import 'package:get/get.dart';
import 'package:task_watt/core/api/dio_client.dart';
import 'package:task_watt/core/api/network_services.dart';
import 'package:task_watt/features/auth/controller/auth_controller.dart';
import 'package:task_watt/features/auth/repositories/auth_%20repository.dart';
import 'package:task_watt/features/map/controller/address_coordinate_controller.dart';
import 'package:task_watt/features/map/controller/main_map_controller.dart';

import 'features/map/controller/search_location_controller.dart';

void setup() {
  // Services
  final NetworkServices netWorkServices = Get.put(DioClient());

  // Repositories
  final AuthRepository authRepository = Get.put(AuthRepositoryImpl(netWorkServices));

  // Controllers
  Get.put(AuthController(authRepository));
  Get.put(MainMapController());
  Get.put(AddressCoordinateController());
  Get.put(SearchLocationController());
}
