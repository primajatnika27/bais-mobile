import 'package:bais_mobile/core/helpers/utils/color_extensions.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/app_bar_general.dart';
import 'package:bais_mobile/core/widgets/bottom_button_widget.dart';
import 'package:bais_mobile/features/incident_report/controllers/incident_report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IncidentMap extends GetView<IncidentReportController> {
  const IncidentMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: const AppBarGeneral(
        title: 'Maps',
        withTabBar: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Obx(() {
              LatLng initialPosition = LatLng(controller.currentLat.value, controller.currentLong.value);
              return GoogleMap(
                buildingsEnabled: true,
                mapType: MapType.terrain,
                initialCameraPosition: CameraPosition(
                  target: initialPosition,
                  zoom: 15.0,
                ),
                onTap: (LatLng position) async {
                  controller.addMarker(position);
                  String address = await controller.getAddressFromLatLng(position);
                  controller.updateAddress(address);

                  controller.miniMapController?.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: position,
                        zoom: 15.0,
                      ),
                    ),
                  );
                },
                markers: Set<Marker>.of(controller.markers),
                onMapCreated: (GoogleMapController mapController) {
                  controller.mapController = mapController;
                },
              );
            }),
            Positioned(
              bottom: 120, // Adjust this value to position the button higher
              right: 5,
              child: FloatingActionButton(
                backgroundColor: AppTheme.white950,
                onPressed: () async {
                  await controller.getLocation();
                  controller.mapController?.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: LatLng(controller.currentLat.value, controller.currentLong.value),
                        zoom: 17.0,
                      ),
                    ),
                  );

                  controller.miniMapController?.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: LatLng(controller.currentLat.value, controller.currentLong.value),
                        zoom: 15.0,
                      ),
                    ),
                  );
                },
                child: const Icon(
                  Icons.my_location,
                  color: AppTheme.secondary900,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 146,
        decoration: const BoxDecoration(
          color: AppTheme.white950,
          border: Border(
            top: BorderSide(
              color: Color(0xFFEAECF0),
              width: 1,
            ),
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Obx(() {
                return Text(
                  controller.address.value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: HexColor('#1E2024'),
                  ),
                );
              }),
            ),
            BottomButtonWidget(
              title: 'Select Location',
              usingBorder: false,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
