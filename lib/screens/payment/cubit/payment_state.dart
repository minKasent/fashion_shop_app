import 'package:fashion_shop/models/card_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_state.freezed.dart';

@freezed
class PaymentState with _$PaymentState {
  const factory PaymentState({
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    @Default('') String apiErrorMessage,
    @Default([]) List<CardModel> cards,
    CardModel? selectedCard,
  }) = _PaymentState;
}
