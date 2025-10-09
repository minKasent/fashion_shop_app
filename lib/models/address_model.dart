import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_model.freezed.dart';
part 'address_model.g.dart';

@freezed
class AddressModel with _$AddressModel {
  const factory AddressModel({
    required String id,
    required String userId,
    required String streetAddress,
    required String city,
    required String state,
    required String zipCode,
    required String createdAt,
    required String updatedAt,
    @Default(false) bool isDefault,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) => _$AddressModelFromJson(json);
}
