import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/core/dialogs/general_dialogs.dart';
import 'package:bais_mobile/core/helpers/database_helper.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/dropdown_input.dart';
import 'package:bais_mobile/core/widgets/photo_section_input.dart';
import 'package:bais_mobile/data/models/form_data/task_report_form_data.dart';
import 'package:bais_mobile/data/models/task_report_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncidentReportController extends GetxController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Firebase FireStore instance
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  var usersId = "".obs;

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
    'Medical Incident',
    'Minor Incident',
    'Near Miss',
    'Potential Hazard',
  ];

  final DropdownController<String> incidentLevelController =
      DropdownController<String>();
  final List<String> incidentLevel = [
    'Low',
    'Medium',
    'High',
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

  /// Payload
  var payload = TaskReportModel();

  @override
  void onInit() {
    super.onInit();
    incidentTypeController.setItems(incidentType);
    incidentLevelController.setItems(incidentLevel);

    getLocation();
    getUserData();
  }

  @override
  void onClose() {
    super.onClose();
    incidentTypeController.dispose();
  }

  void showLoadingPopup() {
    GeneralDialog.showLoadingDialog();
  }

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usersId.value = prefs.getString('userId') ?? '';
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

  void onSubmitTaskReport() async {
    showLoadingPopup();
    payload.userId = usersId.value;
    payload.reporterName = reporterNameController.text;
    payload.incidentDate = incidentDateController.text;
    payload.incidentTime = incidentTimeController.text;
    payload.incidentDescription = incidentDescriptionController.text;
    payload.incidentType = incidentTypeController.selectedValue.value;
    payload.incidentLevel = incidentLevelController.selectedValue.value;
    payload.incidentPhotoPath = incidentPhotoModel.value.selectedImagePath;
    payload.incidentLocationLat = currentLat.value;
    payload.incidentLocationLng = currentLong.value;
    payload.incidentLocationAddress = location.value;

    await _fireStore.collection('incident').add(payload.toJson());
    Get.snackbar(
      'Success',
      'Incident Report has been submitted',
      backgroundColor: AppTheme.green500,
      colorText: Colors.white,
    );

    Get.toNamed(Routes.incidentReportSuccess);
  }

  Future<void> saveDataToLocal(String data) async {
    final formData = TaskReportFormData(
      payload: data,
    );
    await _dbHelper.insertTaskReport(formData);
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
