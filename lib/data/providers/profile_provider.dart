import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileProvider {
  final FirebaseFirestore _fireStore;

  ProfileProvider(this._fireStore);

  Future<QuerySnapshot?> getUserDataByEmail(String email) async {
    QuerySnapshot snapshot = await _fireStore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot;
    }

    return null;
  }
}
