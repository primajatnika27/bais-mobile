import 'package:bais_mobile/core/widgets/dropdown_input.dart';
import 'package:bais_mobile/core/widgets/photo_section_input.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class IncidentReportController extends GetxController {
  final TextEditingController reporterNameController = TextEditingController();
  final TextEditingController incidentDateController = TextEditingController();
  final TextEditingController incidentTimeController = TextEditingController();
  final TextEditingController incidentDescriptionController =
      TextEditingController();
  final Rx<PhotoSectionInputModel> incidentPhotoModel =
      PhotoSectionInputModel(nameId: "INCIDENT").obs;

  final DropdownController<String> incidentTypeController =
      DropdownController<String>();
  final List<String> incidentType = [
    'A',
    'B',
    'C',
  ];

  final DropdownController<String> incidentLevelController =
      DropdownController<String>();
  final List<String> incidentLevel = [
    'Level 1',
    'Level 2',
    'Level 3',
  ];

  final RxInt currentIndex = 0.obs;
  final RxList<String> tabs = [
    'Incident',
    'Files',
    'Location',
  ].obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }

  var location = "Memuat lokasi...".obs;
  var currentLat = 0.0.obs;
  var currentLong = 0.0.obs;
  GoogleMapController? mapController;
  GoogleMapController? miniMapController;

  /// Marker
  var markers = <Marker>{}.obs;
  var address = ''.obs;

  @override
  void onInit() {
    super.onInit();
    incidentTypeController.setItems(incidentType);
    incidentLevelController.setItems(incidentLevel);

    getLocation();
  }

  @override
  void onClose() {
    super.onClose();
    incidentTypeController.dispose();
  }

  void addMarker(LatLng position) {
    final marker = Marker(
      markerId: MarkerId(position.toString()),
      position: position,
    );
    currentLat.value = position.latitude;
    currentLong.value = position.longitude;
    markers.clear();
    markers.add(marker);
  }

  void updateAddress(String newAddress) {
    address.value = newAddress;
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

    var addressLoc = await getAddressFromLatLng(
        LatLng(locationData.latitude!, locationData.longitude!));
    location.value = addressLoc;
    address.value = addressLoc;
    currentLat.value = locationData.latitude!;
    currentLong.value = locationData.longitude!;
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId('initialMarker'),
        position: LatLng(currentLat.value, currentLong.value),
      ),
    );
  }
}
