import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:task_watt/features/map/controller/main_map_controller.dart';
import 'package:task_watt/features/map/controller/search_location_controller.dart';
import 'package:task_watt/features/map/views/select_location_from_map_view.dart';
import 'package:task_watt/features/map/widgets/search_bar_widget.dart';

import '../controller/address_coordinate_controller.dart';

class SearchLocationView extends StatefulWidget {
  const SearchLocationView({
    this.isOriginDestination = false,
    super.key,
  });

  final bool isOriginDestination;

  @override
  State<SearchLocationView> createState() => _SearchLocationViewState();
}

class _SearchLocationViewState extends State<SearchLocationView> {
  final AddressCoordinateController addressCoordinateController = Get.find();
  final MainMapController mainMapController = Get.find();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        notificationPredicate: (ScrollNotification notification) {
          return false;
        },
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
      ),
      body: Column(
        children: [
          if (Platform.isIOS) const CustomSearchBar(),
          if (Platform.isAndroid) const SafeArea(child: CustomSearchBar()),
          Container(
            height: 40,
            width: mediaQuery.width,
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            // decoration: const BoxDecoration(
            //   color: Colors.black12,
            //   borderRadius: BorderRadius.all(
            //     Radius.circular(8),
            //   ),
            // ),
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => SelectLocationFromMapView(
                      isOriginDestination: widget.isOriginDestination,
                    ));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Icon(Icons.my_location_rounded),
                    SizedBox(width: 20),
                    Text("Pick locations from map"),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GetX<SearchLocationController>(
              builder: (searchLocationController) {
                return ListView.builder(
                  itemCount: searchLocationController.predictions.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextButton(
                        onPressed: () async {
                          Get.back();
                          Get.back();
                          final location = await searchLocationController.getLatLanFromAddress(searchLocationController.predictions[i]);

                          if (widget.isOriginDestination) {
                            addressCoordinateController.setOriginAddress(searchLocationController.predictions[i].description);
                            //addressCoordinateController.fetchOriginAddress(LatLng(location.latitude, location.longitude));
                            mainMapController.addOriginMarker(LatLng(location.latitude, location.longitude));
                          } else {
                            addressCoordinateController.setDestinationAddress(searchLocationController.predictions[i].description);
                            // addressCoordinateController.fetchDestinationAddress(LatLng(location.latitude, location.longitude));
                            mainMapController.addDestinationMarker(LatLng(location.latitude, location.longitude));
                          }
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.black54),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                searchLocationController.predictions[i].description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Colors.black87,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
