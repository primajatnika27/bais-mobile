import 'dart:convert';

import 'package:bais_mobile/core/helpers/database_helper.dart';
import 'package:bais_mobile/data/models/task_report_model.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';
import 'package:rubber/rubber.dart';

class DashboardController extends GetxController
    with GetTickerProviderStateMixin {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  var location = "Search Location...".obs;
  final currentLocation = Rx<LatLng?>(null);
  var currentLat = 0.0.obs;
  var currentLong = 0.0.obs;
  GoogleMapController? mapController;
  GoogleMapController? miniMapController;

  /// Marker
  var markers = <Marker>{}.obs;
  var address = ''.obs;

  /// Dashboard Data
  var lastTimeIncidentTotal = 0.obs;
  var medicalTreatmentTotal = 0.obs;
  var minorIncidentTotal = 0.obs;
  var nearMissTotal = 0.obs;
  var potentialHazardTotal = 0.obs;

  var taskReports = <TaskReportModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getLocation();
    getLocalData();
  }

  @override
  Future<void> refresh() async {}

  void getLocalData() async {
    List<String> data = await _dbHelper.getAllTaskReport();
    taskReports.value = data.map((jsonString) {
      return TaskReportModel.fromJson(jsonDecode(jsonString));
    }).toList();

    lastTimeIncidentTotal.value = taskReports
        .where((element) => element.incidentType == "Last Time Incident")
        .length;
    medicalTreatmentTotal.value = taskReports
        .where((element) => element.incidentType == "Medical Incident")
        .length;
    minorIncidentTotal.value = taskReports
        .where((element) => element.incidentType == "Minor Incident")
        .length;
    nearMissTotal.value = taskReports
        .where((element) => element.incidentType == "Near Miss")
        .length;
    potentialHazardTotal.value = taskReports
        .where((element) => element.incidentType == "Potential Hazard")
        .length;

    markers.value = taskReports.asMap().entries.map((entry) {
      int index = entry.key;
      TaskReportModel report = entry.value;
      return Marker(
        markerId: MarkerId((index + 1).toString()), // Use index + 1 as ID
        position:
            LatLng(report.incidentLocationLat!, report.incidentLocationLng!),
        infoWindow: InfoWindow(
            title: report.incidentType, snippet: report.incidentDescription),
      );
    }).toSet();
  }

  Future<String> getAddressFromLatLng(LatLng position) async {
    try {
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        geocoding.Placemark place = placemarks[0];

        return "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
      }
    } catch (e) {
      return "Alamat tidak ditemukan";
    }
    return "Alamat tidak ditemukan";
  }

  Future<void> getLocation() async {
    Location locationService = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await locationService.requestService();
      if (!serviceEnabled) {
        location.value = "Layanan lokasi tidak diaktifkan";
        return;
      }
    }

    permissionGranted = await locationService.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationService.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        location.value = "Izin lokasi tidak diberikan";
        return;
      }
    }

    locationData = await locationService.getLocation();

    if (locationData.latitude == null || locationData.longitude == null) {
      location.value = "Lokasi tidak ditemukan";
      return;
    }

    // Update the currentLocation reactive variable
    currentLocation.value =
        LatLng(locationData.latitude!, locationData.longitude!);

    var addressLoc = await getAddressFromLatLng(
      LatLng(locationData.latitude!, locationData.longitude!),
    );
    location.value = addressLoc;
    address.value = addressLoc;
    currentLat.value = locationData.latitude!;
    currentLong.value = locationData.longitude!;
    markers.clear();
    getLocalData();
  }
}
