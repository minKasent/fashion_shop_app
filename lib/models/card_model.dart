import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_model.freezed.dart';
part 'card_model.g.dart';

@freezed
class CardModel with _$CardModel {
  const factory CardModel({
    required String id,
    required String userId,
    required String cardNumber,
    required String cardholderName,
    required String expiryDate,
    required String cvv,
    required String cardType,
    required String createdAt,
    required String updatedAt,
    @Default(false) bool isDefault,
  }) = _CardModel;

  factory CardModel.fromJson(Map<String, dynamic> json) =>
      _$CardModelFromJson(json);
}
