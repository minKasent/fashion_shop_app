import 'package:fashion_shop/models/address_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_state.freezed.dart';

@freezed
class AddressState with _$AddressState {
  const factory AddressState({
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    @Default('') String apiErrorMessage,
    @Default([]) List<AddressModel> addresses,
    AddressModel? selectedAddress,
  }) = _AddressState;
}
