import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/core/helpers/utils/color_extensions.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/card_wrapper_widget.dart';
import 'package:bais_mobile/core/widgets/info_card.dart';
import 'package:bais_mobile/features/incident_report/controllers/incident_report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IncidentLocationTab extends GetView<IncidentReportController> {
  const IncidentLocationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWrapperWidget(
      title: 'Incident Location',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: selectorMiniMap(),
      ),
    );
  }

  Widget selectorMiniMap() {
    LatLng initialPosition = LatLng(
        controller.currentLat.value, controller.currentLong.value);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Coordinates',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: HexColor('#1D2939'),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 125,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: GoogleMap(
              buildingsEnabled: true,
              mapType: MapType.terrain,
              zoomControlsEnabled: false,
              scrollGesturesEnabled: false,
              // Disable scrolling
              zoomGesturesEnabled: false,
              // Disable zooming
              rotateGesturesEnabled: false,
              // Disable rotating
              tiltGesturesEnabled: false,
              initialCameraPosition: CameraPosition(
                target: initialPosition,
                zoom: 16.0,
              ),
              markers: Set<Marker>.of(controller.markers),
              onMapCreated: (GoogleMapController mapController) {
                controller.miniMapController = mapController;
                controller.addMarker(initialPosition);
              },
              onTap: (LatLng p) => Get.toNamed(Routes.incidentReportMaps),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Obx(() {
          return GestureDetector(
            onTap: () => Get.toNamed(Routes.incidentReportMaps),
            child: InfoCard(
              text: controller.address.value != ''
                  ? controller.address.value
                  : '-',
              borderColor: AppTheme.primary,
              backgroundColor: const Color(0XFFF9FAFB),
              icon: const Icon(
                Icons.location_on,
                color: AppTheme.primary,
              ),
            ),
          );
        }),
      ],
    );
  }
}
