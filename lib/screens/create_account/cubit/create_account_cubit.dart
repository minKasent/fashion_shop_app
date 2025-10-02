import 'package:fashion_shop/core/logging/app_logger.dart';
import 'package:fashion_shop/di/injector.dart';
import 'package:fashion_shop/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  final AuthRepository _authRepository = getIt<AuthRepository>();
  final AppLogger _logger = getIt<AppLogger>();
  CreateAccountCubit() : super(const CreateAccountState());

  Future<void> createAccount({required String email, required String password, required String firstName, required String lastName}) async {
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

  void onClearErrorMessage() {
    emit(state.copyWith(apiErrorMessage: ''));
  }
}
