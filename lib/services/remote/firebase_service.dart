import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_shop/core/logging/app_logger.dart';
import 'package:fashion_shop/models/address_model.dart';
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
      /// register user in firebase auth
      final user = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      /// store user data in firestore
      await _firestore.collection('users').doc(user.user?.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'uid': user.user?.uid,
        'createdAt': DateTime.now().toIso8601String(),
      });
    } catch (e, stackTrace) {
      _logger.e('Error creating user with email and password', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// sign in with email and password
  Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e, stackTrace) {
      _logger.e('Error signing in with email and password', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// get info user
  Future<UserModel?> getUserInfo() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore.collection('users').doc(getCurrentUserId()).get();
      if (!userDoc.exists) {
        _logger.w('User document does not exist for uid: ${getCurrentUserId()}');
        return null;
      }
      final Map<String, dynamic> userData = userDoc.data()!;
      final UserModel user = UserModel.fromJson(userData);
      return user;
    } catch (e, stackTrace) {
      _logger.e('Error getting user info', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// get current user id
  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }

  /// update user info in firestore
  Future<void> updateUserInfo({required String firstName, required String lastName}) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _firestore.collection('users').doc(currentUser.uid).update({
          'firstName': firstName,
          'lastName': lastName,
          'updatedAt': DateTime.now().toIso8601String(),
        });
        _logger.i('User info updated successfully');
      } else {
        throw Exception('No authenticated user found');
      }
    } catch (e, stackTrace) {
      _logger.e('Error updating user info', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e, stackTrace) {
      _logger.e('Error signing out', error: e, stackTrace: stackTrace);
    }
  }

  /// Add user address
  Future<AddressModel> addUserAddress({
    required String streetAddress,
    required String city,
    required String state,
    required String zipCode,
    bool isDefault = false,
  }) async {
    try {
      final String? currentUserId = getCurrentUserId();
      if (currentUserId == null) {
        throw Exception('No authenticated user found');
      }

      final String addressId = _firestore.collection('addresses').doc().id;
      final String now = DateTime.now().toIso8601String();

      final Map<String, dynamic> addressData = {
        'id': addressId,
        'userId': currentUserId,
        'streetAddress': streetAddress,
        'city': city,
        'state': state,
        'zipCode': zipCode,
        'isDefault': isDefault,
        'createdAt': now,
        'updatedAt': now,
      };

      await _firestore.collection('addresses').doc(addressId).set(addressData);

      final AddressModel address = AddressModel.fromJson(addressData);

      _logger.i('Address added successfully with ID: $addressId');
      return address;
    } catch (e, stackTrace) {
      _logger.e('Error adding user address', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Get user addresses
  Future<List<AddressModel>> getUserAddresses() async {
    try {
      final String? currentUserId = getCurrentUserId();
      if (currentUserId == null) {
        throw Exception('No authenticated user found');
      }

      final QuerySnapshot<Map<String, dynamic>> addressSnapshot = await _firestore
          .collection('addresses')
          .where('userId', isEqualTo: currentUserId)
          .get();

      final List<AddressModel> addresses = addressSnapshot.docs.map((doc) => AddressModel.fromJson(doc.data())).toList();

      _logger.i('Retrieved ${addresses.length} addresses for user');
      return addresses;
    } catch (e, stackTrace) {
      _logger.e('Error getting user addresses', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Update user address
  Future<void> updateUserAddress({
    required String addressId,
    required String streetAddress,
    required String city,
    required String state,
    required String zipCode,
    bool isDefault = false,
  }) async {
    try {
      final String? currentUserId = getCurrentUserId();
      if (currentUserId == null) {
        throw Exception('No authenticated user found');
      }

      // Verify the address belongs to the current user
      final DocumentSnapshot<Map<String, dynamic>> addressDoc = await _firestore.collection('addresses').doc(addressId).get();

      if (!addressDoc.exists) {
        throw Exception('Address not found');
      }

      final Map<String, dynamic>? addressData = addressDoc.data();
      if (addressData?['userId'] != currentUserId) {
        throw Exception('Address does not belong to current user');
      }

      await _firestore.collection('addresses').doc(addressId).update({
        'streetAddress': streetAddress,
        'city': city,
        'state': state,
        'zipCode': zipCode,
        'isDefault': isDefault,
        'updatedAt': DateTime.now().toIso8601String(),
      });

      _logger.i('Address updated successfully');
    } catch (e, stackTrace) {
      _logger.e('Error updating user address', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Delete user address
  Future<void> deleteUserAddress({required String addressId}) async {
    try {
      final String? currentUserId = getCurrentUserId();
      if (currentUserId == null) {
        throw Exception('No authenticated user found');
      }

      // Verify the address belongs to the current user
      final DocumentSnapshot<Map<String, dynamic>> addressDoc = await _firestore.collection('addresses').doc(addressId).get();

      if (!addressDoc.exists) {
        throw Exception('Address not found');
      }

      final Map<String, dynamic>? addressData = addressDoc.data();
      if (addressData?['userId'] != currentUserId) {
        throw Exception('Address does not belong to current user');
      }

      await _firestore.collection('addresses').doc(addressId).delete();
      _logger.i('Address deleted successfully');
    } catch (e, stackTrace) {
      _logger.e('Error deleting user address', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
