import 'package:bais_mobile/data/models/task_model.dart';
import 'package:bais_mobile/data/models/task_report_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController
    with GetTickerProviderStateMixin {

  // Firebase FireStore instance
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  var location = "Search Location...".obs;
  final currentLocation = Rx<LatLng?>(null);
  var currentLat = 0.0.obs;
  var currentLong = 0.0.obs;
  GoogleMapController? mapController;
  GoogleMapController? miniMapController;

  /// Marker
  var markers = <Marker>{}.obs;
  var address = ''.obs;

  var newTaskTotal = 0.obs;
  var onGoingTaskTotal = 0.obs;
  var submittedTaskTotal = 0.obs;
  var completedTaskTotal = 0.obs;
  var rejectedTaskTotal = 0.obs;

  var taskReports = <TaskReportModel>[].obs;
  var tasks = <TaskModel?>[].obs;

  var usersName = "".obs;
  var usersId = "".obs;

  @override
  void onInit() {
    super.onInit();
    getLocation();
    getIncidentData();
    getUserData();
  }

  @override
  Future<void> refresh() async {}

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usersName.value = prefs.getString('userName') ?? '';
    usersId.value = prefs.getString('userId') ?? '';
  }

  void getIncidentData() async {
    print("Loading data from Firestore");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId') ?? '';
    try {
      // Fetch data from Firestore
      QuerySnapshot snapshot = await _fireStore
          .collection('incident')
          .where('user_id', isEqualTo: userId)
          .get();

      // Map the documents to TaskReportModel
      taskReports.value = snapshot.docs.map((doc) {
        return TaskReportModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      // Create markers for each task report
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
    } catch (e) {
      print("Error fetching data from Firestore: $e");
    }
  }

  void fetchTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('userEmail');

    try {
      // Fetch data from Firestore
      QuerySnapshot snapshot = await _fireStore
          .collection('tasks')
          .where('assigned.email', isEqualTo: email)
          .get();

      // Map the documents to TaskReportModel
      tasks.value = snapshot.docs.map((doc) {
        return TaskModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      newTaskTotal.value = tasks
          .where((element) => element?.status == "New Task")
          .length;
      onGoingTaskTotal.value = tasks
          .where((element) => element?.status == "On Going")
          .length;
      submittedTaskTotal.value = tasks
          .where((element) => element?.status == "Submitted")
          .length;
      completedTaskTotal.value = tasks
          .where((element) => element?.status == "Completed")
          .length;
      rejectedTaskTotal.value = tasks
          .where((element) => element?.status == "Rejected")
          .length;
    } catch (e) {
      print("Error fetching data from Firestore: $e");
    }
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
    getIncidentData();
  }
}
