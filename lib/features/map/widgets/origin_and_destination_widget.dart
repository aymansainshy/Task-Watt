import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_watt/features/map/controller/address_coordinate_controller.dart';
import 'package:task_watt/features/map/controller/main_map_controller.dart';
import 'package:task_watt/features/map/views/search_location_view.dart';

class OriginAndDestinationWidget extends StatelessWidget {
  const OriginAndDestinationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    return Container(
      height: Platform.isIOS ? mediaQuery.height * 0.25 : mediaQuery.height * 0.23,
      width: mediaQuery.width,
      color: Theme.of(context).colorScheme.onInverseSurface,
      padding: const EdgeInsets.only(top: 20),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.my_location, color: Colors.black),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const SearchLocationView(isOriginDestination: true));
                        },
                        child: Container(
                          height: Platform.isIOS ? constraints.maxHeight / 3.5 : constraints.maxHeight / 4,
                          width: constraints.maxWidth * 0.80,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              width: 1.5,
                              color: Colors.black26,
                            ),
                          ),
                          child: GetX<AddressCoordinateController>(
                            builder: (addressCoordinateController) {
                              switch (addressCoordinateController.originAddressStatus) {
                                case OriginAddressStatus.idl:
                                  return Center(
                                    child: Text(
                                      'Pick Start location',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: Colors.black54,
                                          ),
                                    ),
                                  );
                                case OriginAddressStatus.loading:
                                  return const Row(
                                    children: [
                                      Expanded(child: SizedBox.shrink()),
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                        ),
                                      ),
                                    ],
                                  );
                                case OriginAddressStatus.success:
                                  return Center(
                                      child: Text(
                                    maxLines: 1,
                                    addressCoordinateController.originAddress,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          overflow: TextOverflow.clip,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ));
                                case OriginAddressStatus.failure:
                                  return const Text('Unable to fetch route information');
                                default:
                                  return Container();
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 15),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: CircleAvatar(backgroundColor: Colors.black54, radius: 1.5),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 2),
                      child: CircleAvatar(backgroundColor: Colors.black54, radius: 1.5),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 2),
                      child: CircleAvatar(backgroundColor: Colors.black54, radius: 1.5),
                    ),
                  ),

                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: Colors.red),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const SearchLocationView(isOriginDestination: false));
                        },
                        child: Container(
                          height: Platform.isIOS ? constraints.maxHeight / 3.5 : constraints.maxHeight / 4,
                          width: constraints.maxWidth * 0.80,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              width: 1.5,
                              color: Colors.black26,
                            ),
                          ),
                          child: GetX<AddressCoordinateController>(
                            builder: (addressCoordinateController) {
                              switch (addressCoordinateController.destinationAddressStatus) {
                                case DestinationAddressStatus.idl:
                                  return Center(
                                    child: Text(
                                      'Pick Destination location',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black54),
                                    ),
                                  );
                                case DestinationAddressStatus.loading:
                                  return const Row(
                                    children: [
                                      Expanded(child: SizedBox.shrink()),
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                        ),
                                      ),
                                    ],
                                  );
                                case DestinationAddressStatus.success:
                                  return Center(
                                    child: Text(
                                      maxLines: 1,
                                      addressCoordinateController.destinationAddress,
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            overflow: TextOverflow.clip,
                                          ),
                                    ),
                                  );
                                case DestinationAddressStatus.failure:
                                  return const Text('Failed to fetch route information');
                                default:
                                  return Container();
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GetX<MainMapController>(
                    builder: (mainMapController) {
                      switch (mainMapController.polylineState) {
                        case PolylineState.intial:
                          return const SizedBox.shrink();
                        case PolylineState.loading:
                          return const Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                              ),
                            ),
                          );
                        case PolylineState.success:
                          return SizedBox(
                            height: Platform.isIOS ? constraints.maxHeight / 3.5 : constraints.maxHeight / 4,
                            width: constraints.maxWidth * 0.80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: constraints.maxHeight / 3,
                                  width: (constraints.maxWidth * 0.80) / 3,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withAlpha(80),
                                    // border: Border.all(
                                    //   color: Colors.black,
                                    //   width: 1.5,
                                    // ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        const Icon(Icons.social_distance),
                                        Text(
                                          mainMapController.polylineResult.distance ?? "",
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: constraints.maxHeight / 3,
                                  width: (constraints.maxWidth * 0.80) / 3.5,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withAlpha(80),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        const Icon(Icons.drive_eta_outlined),
                                        Text(
                                          mainMapController.polylineResult.duration ?? "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: constraints.maxHeight / 4,
                                  width: (constraints.maxWidth * 0.80) / 3,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withAlpha(80),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        const Icon(Icons.monetization_on_outlined),
                                        Text(
                                          "${(mainMapController.totalCost).toStringAsFixed(2)} AED",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        case PolylineState.failure:
                          return const Text('Failed to fetch route information');
                        default:
                          return Container();
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
