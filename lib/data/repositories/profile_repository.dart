import 'package:bais_mobile/data/providers/profile_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileRepository {
  late final ProfileProvider _provider;

  ProfileRepository() {
    final fireStore = FirebaseFirestore.instance;
    _provider = ProfileProvider(fireStore);
  }

  Future<QuerySnapshot?> getUserDataByEmail(String email) =>
      _provider.getUserDataByEmail(
        email,
      );
}
