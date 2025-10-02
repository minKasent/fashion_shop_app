import 'package:fashion_shop/core/logging/app_logger.dart';
import 'package:fashion_shop/di/injector.dart';
import 'package:fashion_shop/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository _authRepository = getIt<AuthRepository>();
  final AppLogger _logger = getIt<AppLogger>();
  SignInCubit() : super(SignInState());

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _authRepository.createUserWithEmailAndPassword(email: email, password: password, firstName: firstName, lastName: lastName);
      emit(state.copyWith(isSuccess: true));
    } catch (e, stackTrace) {
      emit(state.copyWith(apiErrorMessage: e.toString()));
      _logger.e(e, stackTrace: stackTrace);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _authRepository.signInWithEmailAndPassword(email: email, password: password);
      emit(state.copyWith(isSuccess: true));
    } catch (e, stackTrace) {
      emit(state.copyWith(apiErrorMessage: e.toString()));
      _logger.e(e, stackTrace: stackTrace);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void onClearSignInErrorMessage() {
    emit(state.copyWith(apiErrorMessage: ''));
  }
}
