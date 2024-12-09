import 'package:bais_mobile/data/providers/auth_provider.dart' as provider;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  late final provider.AuthProvider _provider;

  AuthRepository() {
    final fireStore = FirebaseFirestore.instance;
    final fireAuth = FirebaseAuth.instance;
    _provider = provider.AuthProvider(fireStore, fireAuth);
  }

  Future<QueryDocumentSnapshot?> getUserDataByEmail(String email) =>
      _provider.checkUser(
        email,
      );

  Future login(String email, String password) async {
    return _provider.login(email, password);
  }

  Future logout() async {
    return _provider.logout();
  }
}