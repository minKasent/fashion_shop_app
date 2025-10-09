import 'package:fashion_shop/core/logging/app_logger.dart';
import 'package:fashion_shop/models/address_model.dart';
import 'package:fashion_shop/models/user_model.dart';
import 'package:fashion_shop/services/remote/firebase_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserRepository {
  final FirebaseService _firebaseService;
  final AppLogger _logger;

  UserRepository(this._firebaseService, this._logger);

  Future<UserModel?> getUserInfo() async {
    try {
      return await _firebaseService.getUserInfo();
    } catch (e, stackTrace) {
      _logger.e('Error getting user info', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Update user info
  Future<void> updateUserInfo({required String firstName, required String lastName}) async {
    try {
      await _firebaseService.updateUserInfo(firstName: firstName, lastName: lastName);
      _logger.i('User info updated successfully');
    } catch (e, stackTrace) {
      _logger.e('Error updating user info', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseService.signOut();
    } catch (e, stackTrace) {
      _logger.e('Error signing out', error: e, stackTrace: stackTrace);
      rethrow;
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
      final AddressModel address = await _firebaseService.addUserAddress(
        streetAddress: streetAddress,
        city: city,
        state: state,
        zipCode: zipCode,
        isDefault: isDefault,
      );
      _logger.i('User address added successfully');
      return address;
    } catch (e, stackTrace) {
      _logger.e('Error adding user address', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Get user addresses
  Future<List<AddressModel>> getUserAddresses() async {
    try {
      final List<AddressModel> addresses = await _firebaseService.getUserAddresses();
      _logger.i('User addresses retrieved successfully: ${addresses.length} addresses');
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
      await _firebaseService.updateUserAddress(
        addressId: addressId,
        streetAddress: streetAddress,
        city: city,
        state: state,
        zipCode: zipCode,
        isDefault: isDefault,
      );
      _logger.i('User address updated successfully');
    } catch (e, stackTrace) {
      _logger.e('Error updating user address', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Delete user address
  Future<void> deleteUserAddress({required String addressId}) async {
    try {
      await _firebaseService.deleteUserAddress(addressId: addressId);
      _logger.i('User address deleted successfully');
    } catch (e, stackTrace) {
      _logger.e('Error deleting user address', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
