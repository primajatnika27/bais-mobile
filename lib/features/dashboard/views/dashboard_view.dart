import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/features/dashboard/controllers/dashboard_controller.dart';
import 'package:bais_mobile/features/dashboard/widgets/location_widget.dart';
import 'package:bais_mobile/features/dashboard/widgets/task_card.dart';
import 'package:bais_mobile/features/dashboard/widgets/user_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    LatLng initialPosition =
        LatLng(controller.currentLat.value, controller.currentLong.value);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.small(
              heroTag: 'call-incident',
              backgroundColor: AppTheme.primary,
              onPressed: () {},
              child: const Icon(Icons.call, color: AppTheme.white),
            ),
            const SizedBox(height: 16),
            FloatingActionButton.small(
              heroTag: 'add-incident',
              backgroundColor: AppTheme.primary,
              onPressed: () {
                Get.toNamed(Routes.incidentReport);
              },
              child: const Icon(Icons.add, color: AppTheme.white),
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Stack(
            children: [
              Container(
                color: AppTheme.background,
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppTheme.primary,
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: AppTheme.primary,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset(
                            'assets/images/svg/dashboard_illustration.svg',
                            color: AppTheme.white950,
                            height: 100,
                            width: 50,
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 18),
                                  Image.asset(
                                    'assets/images/logo-maruti.png',
                                    height: 60,
                                  ),
                                  const LocationWidget(),
                                  const UserWidget(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 500,
                            color: Colors.grey.shade200,
                            child: GoogleMap(
                              initialCameraPosition: const CameraPosition(
                                target: LatLng(-6.2088, 106.8456),
                                // Koordinat pusat Jakarta
                                zoom: 13.0,
                              ),
                              zoomGesturesEnabled: true,
                              zoomControlsEnabled: false,
                              mapType: MapType.terrain,
                              onMapCreated:
                                  (GoogleMapController mapController) {
                                controller.mapController = mapController;
                              },
                              markers: {
                                const Marker(
                                  markerId: MarkerId('marker1'),
                                  position: LatLng(
                                      -6.2088, 106.8456), // Pusat Jakarta
                                ),
                                const Marker(
                                  markerId: MarkerId('marker2'),
                                  position: LatLng(
                                      -6.2146, 106.8451), // Lebih ke utara
                                ),
                                const Marker(
                                  markerId: MarkerId('marker3'),
                                  position: LatLng(
                                      -6.2015, 106.8500), // Lebih ke timur
                                ),
                                const Marker(
                                  markerId: MarkerId('marker4'),
                                  position: LatLng(
                                      -6.2100, 106.8400), // Lebih ke barat
                                ),
                                const Marker(
                                  markerId: MarkerId('marker5'),
                                  position: LatLng(
                                      -6.2200, 106.8550), // Lebih ke selatan
                                ),
                              },
                            ), // Loading indicator until location is available
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: FloatingActionButton.extended(
                                  onPressed: () {
                                    showDashboardBottomSheet();
                                  },
                                  label: const Text(
                                    'View Dashboard',
                                    style: TextStyle(
                                      color: AppTheme.white950,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  icon: SvgPicture.asset(
                                      'assets/icons/ic_setting_white.svg'),
                                  backgroundColor: AppTheme.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDashboardBottomSheet() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.2,
              maxChildSize: 0.9,
              expand: false,
              builder: (context, scrollController) {
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.8,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: ListView(
                      children: [
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 40,
                            height: 5,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFCDCFD0),
                              borderRadius: BorderRadius.circular(2.5),
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(),
                          padding: const EdgeInsets.all(16.0),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TaskCard(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
