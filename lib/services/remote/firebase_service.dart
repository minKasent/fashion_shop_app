import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_shop/core/logging/app_logger.dart';
import 'package:fashion_shop/models/user_model.dart';
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
      final user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firestore.collection('users').doc(user.user?.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'uid': user.user?.uid,
        'createdAt': DateTime.now(),
      });
    } catch (e, stackTrace) {
      _logger.e(
        'Error creating user with email and password',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// sign in with email and password
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e, stackTrace) {
      _logger.e(
        'Error signing in with email and password',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// get info user
  Future<UserModel?> getUserInfo({required String uid}) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(uid).get();
      if (!userDoc.exists) {
        _logger.w('User document does not exist for uid: $uid');
        return null;
      }
      final Map<String, dynamic> userData = userDoc.data()!;
      final UserModel user = UserModel(
        uid: userData['uid'] as String,
        email: userData['email'] as String,
        firstName: userData['firstName'] as String,
        lastName: userData['lastName'] as String,
        createdAt: (userData['createdAt'] as Timestamp).toDate(),
      );
      return user;
    } catch (e, stackTrace) {
      _logger.e(
        'Error getting user info',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// get current user id
  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }

  /// sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e, stackTrace) {
      _logger.e(
        'Error signing out',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }
}
