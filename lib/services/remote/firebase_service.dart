import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_shop/core/logging/app_logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class FirebaseService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final AppLogger _logger;

  FirebaseService(this._auth, this._firestore, this._logger);

  /// create user with email and password
  /// store user data in firestore collection users
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _firestore.collection('users').doc(user.user?.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'uid': user.user?.uid,
        'createdAt': DateTime.now(),
      });
    } catch (e, stackTrace) {
      _logger.e('Error creating user with email and password', error: e, stackTrace: stackTrace);
    }
  }

  /// sign in with email and password
  Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e, stackTrace) {
      _logger.e('Error signing in with email and password', error: e, stackTrace: stackTrace);
    }
  }
}
