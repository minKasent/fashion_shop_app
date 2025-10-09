import 'package:fashion_shop/core/logging/app_logger.dart';
import 'package:fashion_shop/repositories/user_repository.dart';
import 'package:fashion_shop/screens/setting/cubit/setting_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class SettingCubit extends Cubit<SettingState> {
  final UserRepository _userRepository;
  final AppLogger _logger;

  SettingCubit(this._userRepository, this._logger) : super(const SettingState());

  Future<void> loadUserInfo() async {
    emit(state.copyWith(isLoading: true));
    try {
      final userInfo = await _userRepository.getUserInfo();
      if (userInfo == null) {
        emit(state.copyWith(apiErrorMessage: 'Failed to load user info'));
        return;
      }
      emit(state.copyWith(userInfo: userInfo, isSuccess: true));
    } catch (e, stackTrace) {
      emit(state.copyWith(apiErrorMessage: e.toString()));
      _logger.e(e, stackTrace: stackTrace);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  /// Update user info
  Future<void> updateUserInfo({required String firstName, required String lastName}) async {
    emit(state.copyWith(isLoading: true, apiErrorMessage: ''));
    try {
      await _userRepository.updateUserInfo(firstName: firstName, lastName: lastName);
      // Reload user info after successful update
      await loadUserInfo();
      _logger.i('User info updated successfully');
    } catch (e, stackTrace) {
      emit(state.copyWith(apiErrorMessage: e.toString()));
      _logger.e('Error updating user info', error: e, stackTrace: stackTrace);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> signOut() async {
    emit(state.copyWith(isLoading: true));
    try {
      await _userRepository.signOut();
      emit(const SettingState());
    } catch (e, stackTrace) {
      emit(state.copyWith(apiErrorMessage: 'Failed to sign out'));
      _logger.e(e, stackTrace: stackTrace);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void onClearSettingErrorMessage() {
    emit(state.copyWith(apiErrorMessage: ''));
  }
}
