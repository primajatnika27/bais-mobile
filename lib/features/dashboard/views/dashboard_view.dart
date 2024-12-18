import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/features/dashboard/controllers/dashboard_controller.dart';
import 'package:bais_mobile/features/dashboard/widgets/location_widget.dart';
import 'package:bais_mobile/features/dashboard/widgets/task_card.dart';
import 'package:bais_mobile/features/dashboard/widgets/user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rubber/rubber.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with TickerProviderStateMixin {
  final controller = Get.put(DashboardController());

  late RubberAnimationController rubberAnimationController;

  @override
  void initState() {
    super.initState();
    rubberAnimationController = RubberAnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBoundValue: AnimationControllerValue(pixel: 100),
      upperBoundValue: AnimationControllerValue(pixel: 500),
      springDescription: SpringDescription.withDampingRatio(
        mass: 1,
        stiffness: 100,
        ratio: 1.1,
      ),
    );
    controller.getIncidentData();
    controller.fetchTasks();
  }

  void expandSheet() {
    rubberAnimationController.expand();
  }

  void collapseSheet() {
    rubberAnimationController.collapse();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.small(
              heroTag: 'video-incident',
              backgroundColor: AppTheme.primary,
              onPressed: () {
                Get.toNamed(Routes.videoStream);
              },
              child: const Icon(
                Iconsax.play,
                color: AppTheme.white,
              ),
            ),
            const SizedBox(height: 16),
            FloatingActionButton.small(
              heroTag: 'add-incident',
              backgroundColor: AppTheme.primary,
              onPressed: () {
                Get.toNamed(Routes.reportLanding);
              },
              child: const Icon(
                Iconsax.additem,
                color: AppTheme.white,
              ),
            )
          ],
        ),
        body: RubberBottomSheet(
          animationController: rubberAnimationController,
          lowerLayer: RefreshIndicator(
            onRefresh: controller.refresh,
            child: SingleChildScrollView(
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
                            const Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 18),
                                      Text(
                                        "SII",
                                        style: TextStyle(
                                          color: AppTheme.white950,
                                          fontSize: 40,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      LocationWidget(),
                                      UserWidget(),
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
                              Obx(
                                () {
                                  final userLocation =
                                      controller.currentLocation.value;
                                  return Container(
                                    height: 500,
                                    color: Colors.grey.shade200,
                                    child: userLocation != null
                                        ? GoogleMap(
                                            initialCameraPosition:
                                                CameraPosition(
                                              target: userLocation,
                                              zoom: 13.0,
                                            ),
                                            zoomGesturesEnabled: true,
                                            zoomControlsEnabled: false,
                                            mapType: MapType.terrain,
                                            onMapCreated: (GoogleMapController
                                                mapController) {
                                              controller.mapController =
                                                  mapController;
                                            },
                                            markers: controller.markers.value,
                                          )
                                        : const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                  );
                                },
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
          upperLayer: _getUpperLayer(),
        ),
      ),
    );
  }

  Widget _getUpperLayer() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const Padding(
            padding: EdgeInsets.only(
              left: 16,
              top: 16,
            ),
            child: Text(
              'Task Summary',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: TaskCard(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
