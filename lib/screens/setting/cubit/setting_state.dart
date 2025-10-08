import 'package:fashion_shop/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_state.freezed.dart';

@freezed
class SettingState with _$SettingState {
  const factory SettingState({
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    @Default('') String apiErrorMessage,
    @Default(null) UserModel? userInfo,
  }) = _SettingState;
}
