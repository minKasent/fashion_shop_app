import 'package:fashion_shop/core/logging/app_logger.dart';
import 'package:fashion_shop/services/remote/firebase_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthRepository {
  final FirebaseService _firebaseService;
  final AppLogger _logger;

  AuthRepository(this._firebaseService, this._logger);

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      await _firebaseService.createUserWithEmailAndPassword(email: email, password: password, firstName: firstName, lastName: lastName);
    } catch (e, stackTrace) {
      _logger.e('Error creating user with email and password', error: e, stackTrace: stackTrace);
    }
  }

  Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      await _firebaseService.signInWithEmailAndPassword(email: email, password: password);
    } catch (e, stackTrace) {
      _logger.e('Error signing in with email and password', error: e, stackTrace: stackTrace);
    }
  }
}
