import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:task_watt/features/map/controller/address_coordinate_controller.dart';
import 'package:task_watt/features/map/controller/main_map_controller.dart';
import 'package:task_watt/features/map/widgets/google_map_widget.dart';
import 'package:task_watt/features/map/widgets/origin_and_destination_widget.dart';
import 'package:task_watt/utils/get_location_permession_helper.dart';

class MainMapView extends StatefulWidget {
  const MainMapView({super.key});

  @override
  State<MainMapView> createState() => _MainMapViewState();
}

class _MainMapViewState extends State<MainMapView> {
  final MainMapController mainMapController = Get.find();
  final AddressCoordinateController addressCoordinateController = Get.find();

  @override
  void initState() {
    super.initState();
    requesteLocationPermissionAndGetLocation()?.then((myLocation) {
      final newInitialCameraPosition = CameraPosition(
        target: LatLng(myLocation.latitude, myLocation.longitude),
        zoom: 14.4746,
      );
      // addressCoordinateController.fetchOriginAddress(LatLng(myLocation.latitude, myLocation.longitude));
      mainMapController.animateCameraPosition(newInitialCameraPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // appBar: AppBar(),
      body: SizedBox(
        height: mediaQuery.height,
        width: mediaQuery.width,
        child: Column(
          children: [
            const OriginAndDestinationWidget(),
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                clipBehavior: Clip.none,
                fit: StackFit.loose,
                children: [
                  GoogleMapWidget(addressCoordinateController: addressCoordinateController),
                ],
              ),
            ),
            if (Platform.isIOS) const SizedBox(height: 20)
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: GetX<MainMapController>(
              builder: (mainMapController) {
                switch (mainMapController.polylineState) {
                  case PolylineState.intial:
                    return const SizedBox.shrink();
                  case PolylineState.loading:
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: FloatingActionButton.extended(
                        onPressed: null,
                        label: Center(child: CircularProgressIndicator()),
                      ),
                    );
                    ;
                  case PolylineState.success:
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: FloatingActionButton.extended(
                        onPressed: () {},
                        label: const Text("Start Trip"),
                      ),
                    );
                  case PolylineState.failure:
                    return const SizedBox.shrink();
                  default:
                    return Container();
                }
              },
            ),
          ),
          const SizedBox(width: 10),
          // FloatingActionButton(
          //   child: const Icon(Icons.my_location),
          //   onPressed: () async {
          //     final myLocation = await requesteLocationPermissionAndGetLocation();
          //
          //     if (myLocation != null) {
          //       final newInitialCameraPosition = CameraPosition(
          //         target: LatLng(myLocation.latitude, myLocation.longitude),
          //         zoom: 14.4746,
          //       );
          //       // addressCoordinateController.fetchOriginAddress(LatLng(myLocation.latitude, myLocation.longitude));
          //       mainMapController.animateCameraPosition(newInitialCameraPosition);
          //       if (!mainMapController.markers.containsKey("origin")) {
          //         mainMapController.addOriginMarker(LatLng(myLocation.latitude, myLocation.longitude));
          //       }
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
