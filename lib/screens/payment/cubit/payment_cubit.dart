import 'package:fashion_shop/core/logging/app_logger.dart';
import 'package:fashion_shop/models/card_model.dart';
import 'package:fashion_shop/repositories/user_repository.dart';
import 'package:fashion_shop/screens/payment/cubit/payment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class PaymentCubit extends Cubit<PaymentState> {
  final UserRepository _userRepository;
  final AppLogger _logger;

  PaymentCubit(this._userRepository, this._logger)
    : super(const PaymentState());

  Future<void> loadCards() async {
    emit(state.copyWith(isLoading: true, apiErrorMessage: ''));
    try {
      final cards = await _userRepository.getUserCards();
      emit(state.copyWith(cards: cards, isSuccess: true));
      _logger.i('Payment cards loaded successfully: ${cards.length} cards');
    } catch (e, stackTrace) {
      emit(state.copyWith(apiErrorMessage: e.toString()));
      _logger.e(
        'Error loading payment cards',
        error: e,
        stackTrace: stackTrace,
      );
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> addCard({
    required String cardNumber,
    required String cardholderName,
    required String expiryDate,
    required String cvv,
    required String cardType,
    bool isDefault = false,
  }) async {
    emit(state.copyWith(isLoading: true, apiErrorMessage: ''));
    try {
      await _userRepository.addUserCard(
        cardNumber: cardNumber,
        cardholderName: cardholderName,
        expiryDate: expiryDate,
        cvv: cvv,
        cardType: cardType,
        isDefault: isDefault,
      );
      // Reload cards after successful addition
      await loadCards();
      _logger.i('Payment card added successfully');
    } catch (e, stackTrace) {
      emit(state.copyWith(apiErrorMessage: e.toString(), isLoading: false));
      _logger.e('Error adding payment card', error: e, stackTrace: stackTrace);
    }
  }

  /// Update existing payment card
  Future<void> updateCard({
    required String cardId,
    required String cardNumber,
    required String cardholderName,
    required String expiryDate,
    required String cvv,
    required String cardType,
    bool isDefault = false,
  }) async {
    emit(state.copyWith(isLoading: true, apiErrorMessage: ''));
    try {
      await _userRepository.updateUserCard(
        cardId: cardId,
        cardNumber: cardNumber,
        cardholderName: cardholderName,
        expiryDate: expiryDate,
        cvv: cvv,
        cardType: cardType,
        isDefault: isDefault,
      );
      await loadCards();
      _logger.i('Payment card updated successfully');
    } catch (e, stackTrace) {
      emit(state.copyWith(apiErrorMessage: e.toString(), isLoading: false));
      _logger.e(
        'Error updating payment card',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Delete payment card
  Future<void> deleteCard({required String cardId}) async {
    emit(state.copyWith(isLoading: true, apiErrorMessage: ''));
    try {
      await _userRepository.deleteUserCard(cardId: cardId);
      await loadCards();
      _logger.i('Payment card deleted successfully');
    } catch (e, stackTrace) {
      emit(state.copyWith(apiErrorMessage: e.toString(), isLoading: false));
      _logger.e(
        'Error deleting payment card',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  void setSelectedCard(CardModel? cardModel) {
    emit(state.copyWith(selectedCard: cardModel));
  }

  void clearErrorMessage() {
    emit(state.copyWith(apiErrorMessage: ''));
  }
}
