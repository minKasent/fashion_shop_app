import 'package:fashion_shop/core/logging/app_logger.dart';
import 'package:fashion_shop/screens/setting/cubit/setting_state.dart';
import 'package:fashion_shop/services/remote/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SettingCubit extends Cubit<SettingState> {
  final FirebaseService _firebaseService;
  final AppLogger _logger;

  SettingCubit(this._firebaseService, this._logger) : super(const SettingState());

  Future<void> loadUserInfo() async {
    emit(state.copyWith(isLoading: true));
    try {
      final String? currentUserId = _firebaseService.getCurrentUserId();
      if (currentUserId == null) {
        emit(state.copyWith(apiErrorMessage: 'User not logged in'));
        return;
      }
      final userInfo = await _firebaseService.getUserInfo(uid: currentUserId);
      if (userInfo == null) {
        emit(state.copyWith(apiErrorMessage: 'Failed to load user info'));
        return;
      }
      emit(state.copyWith(
        userInfo: userInfo,
        isSuccess: true,
      ));
    } catch (e, stackTrace) {
      emit(state.copyWith(apiErrorMessage: e.toString()));
      _logger.e(e, stackTrace: stackTrace);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> signOut() async {
    emit(state.copyWith(isLoading: true));
    try {
      await _firebaseService.signOut();
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
