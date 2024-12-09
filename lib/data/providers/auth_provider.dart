import 'package:bais_mobile/core/constants/key_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final FirebaseFirestore _fireStore;
  final FirebaseAuth _fireAuth;

  AuthProvider(this._fireStore, this._fireAuth);

  Future<QueryDocumentSnapshot?> checkUser(String email) async {
    QuerySnapshot userQuery = await _fireStore
        .collection(TableCollection.users)
        .where('email', isEqualTo: email)
        .get();

    if (userQuery.docs.isNotEmpty) {
      return userQuery.docs.first;
    }

    return null;
  }

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _fireAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        return null;
      } else if (e.code == 'wrong-password') {
        return null;
      } else if( e.code == 'invalid-credential') {
        return null;
      }
    }
    return null;
  }

  Future logout() async {
    await _fireAuth.signOut();
  }
}