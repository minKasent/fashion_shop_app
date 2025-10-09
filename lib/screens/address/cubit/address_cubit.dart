import 'package:fashion_shop/core/logging/app_logger.dart';
import 'package:fashion_shop/models/address_model.dart';
import 'package:fashion_shop/repositories/user_repository.dart';
import 'package:fashion_shop/screens/address/cubit/address_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AddressCubit extends Cubit<AddressState> {
  final UserRepository _userRepository;
  final AppLogger _logger;

  AddressCubit(this._userRepository, this._logger) : super(const AddressState());

  /// Load all addresses for current user
  Future<void> loadAddresses() async {
    emit(state.copyWith(isLoading: true, apiErrorMessage: ''));
    try {
      final addresses = await _userRepository.getUserAddresses();
      emit(state.copyWith(addresses: addresses, isSuccess: true));
      _logger.i('Addresses loaded successfully: ${addresses.length} addresses');
    } catch (e, stackTrace) {
      emit(state.copyWith(apiErrorMessage: e.toString()));
      _logger.e('Error loading addresses', error: e, stackTrace: stackTrace);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  /// Add new address
  Future<void> addAddress({
    required String streetAddress,
    required String city,
    required String stateValue,
    required String zipCode,
    bool isDefault = false,
  }) async {
    emit(state.copyWith(isLoading: true, apiErrorMessage: ''));
    try {
      await _userRepository.addUserAddress(streetAddress: streetAddress, city: city, state: stateValue, zipCode: zipCode, isDefault: isDefault);
      // Reload addresses after successful addition
      await loadAddresses();
      _logger.i('Address added successfully');
    } catch (e, stackTrace) {
      emit(state.copyWith(apiErrorMessage: e.toString(), isLoading: false));
      _logger.e('Error adding address', error: e, stackTrace: stackTrace);
    }
  }

  /// Update existing address
  Future<void> updateAddress({
    required String addressId,
    required String streetAddress,
    required String city,
    required String stateValue,
    required String zipCode,
    bool isDefault = false,
  }) async {
    emit(state.copyWith(isLoading: true, apiErrorMessage: ''));
    try {
      await _userRepository.updateUserAddress(
        addressId: addressId,
        streetAddress: streetAddress,
        city: city,
        state: stateValue,
        zipCode: zipCode,
        isDefault: isDefault,
      );
      // Reload addresses after successful update
      await loadAddresses();
      _logger.i('Address updated successfully');
    } catch (e, stackTrace) {
      emit(state.copyWith(apiErrorMessage: e.toString(), isLoading: false));
      _logger.e('Error updating address', error: e, stackTrace: stackTrace);
    }
  }

  /// Delete address
  Future<void> deleteAddress({required String addressId}) async {
    emit(state.copyWith(isLoading: true, apiErrorMessage: ''));
    try {
      await _userRepository.deleteUserAddress(addressId: addressId);
      // Reload addresses after successful deletion
      await loadAddresses();
      _logger.i('Address deleted successfully');
    } catch (e, stackTrace) {
      emit(state.copyWith(apiErrorMessage: e.toString(), isLoading: false));
      _logger.e('Error deleting address', error: e, stackTrace: stackTrace);
    }
  }

  /// Set selected address for editing
  void setSelectedAddress(AddressModel? addressModel) {
    emit(state.copyWith(selectedAddress: addressModel));
  }

  /// Clear error message
  void clearErrorMessage() {
    emit(state.copyWith(apiErrorMessage: ''));
  }
}
