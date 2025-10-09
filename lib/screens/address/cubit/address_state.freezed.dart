// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AddressState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;
  String get apiErrorMessage => throw _privateConstructorUsedError;
  List<AddressModel> get addresses => throw _privateConstructorUsedError;
  AddressModel? get selectedAddress => throw _privateConstructorUsedError;

  /// Create a copy of AddressState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressStateCopyWith<AddressState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressStateCopyWith<$Res> {
  factory $AddressStateCopyWith(
    AddressState value,
    $Res Function(AddressState) then,
  ) = _$AddressStateCopyWithImpl<$Res, AddressState>;
  @useResult
  $Res call({
    bool isLoading,
    bool isSuccess,
    String apiErrorMessage,
    List<AddressModel> addresses,
    AddressModel? selectedAddress,
  });

  $AddressModelCopyWith<$Res>? get selectedAddress;
}

/// @nodoc
class _$AddressStateCopyWithImpl<$Res, $Val extends AddressState>
    implements $AddressStateCopyWith<$Res> {
  _$AddressStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddressState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSuccess = null,
    Object? apiErrorMessage = null,
    Object? addresses = null,
    Object? selectedAddress = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSuccess: null == isSuccess
                ? _value.isSuccess
                : isSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            apiErrorMessage: null == apiErrorMessage
                ? _value.apiErrorMessage
                : apiErrorMessage // ignore: cast_nullable_to_non_nullable
                      as String,
            addresses: null == addresses
                ? _value.addresses
                : addresses // ignore: cast_nullable_to_non_nullable
                      as List<AddressModel>,
            selectedAddress: freezed == selectedAddress
                ? _value.selectedAddress
                : selectedAddress // ignore: cast_nullable_to_non_nullable
                      as AddressModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of AddressState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressModelCopyWith<$Res>? get selectedAddress {
    if (_value.selectedAddress == null) {
      return null;
    }

    return $AddressModelCopyWith<$Res>(_value.selectedAddress!, (value) {
      return _then(_value.copyWith(selectedAddress: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AddressStateImplCopyWith<$Res>
    implements $AddressStateCopyWith<$Res> {
  factory _$$AddressStateImplCopyWith(
    _$AddressStateImpl value,
    $Res Function(_$AddressStateImpl) then,
  ) = __$$AddressStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    bool isSuccess,
    String apiErrorMessage,
    List<AddressModel> addresses,
    AddressModel? selectedAddress,
  });

  @override
  $AddressModelCopyWith<$Res>? get selectedAddress;
}

/// @nodoc
class __$$AddressStateImplCopyWithImpl<$Res>
    extends _$AddressStateCopyWithImpl<$Res, _$AddressStateImpl>
    implements _$$AddressStateImplCopyWith<$Res> {
  __$$AddressStateImplCopyWithImpl(
    _$AddressStateImpl _value,
    $Res Function(_$AddressStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddressState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSuccess = null,
    Object? apiErrorMessage = null,
    Object? addresses = null,
    Object? selectedAddress = freezed,
  }) {
    return _then(
      _$AddressStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSuccess: null == isSuccess
            ? _value.isSuccess
            : isSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        apiErrorMessage: null == apiErrorMessage
            ? _value.apiErrorMessage
            : apiErrorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        addresses: null == addresses
            ? _value._addresses
            : addresses // ignore: cast_nullable_to_non_nullable
                  as List<AddressModel>,
        selectedAddress: freezed == selectedAddress
            ? _value.selectedAddress
            : selectedAddress // ignore: cast_nullable_to_non_nullable
                  as AddressModel?,
      ),
    );
  }
}

/// @nodoc

class _$AddressStateImpl implements _AddressState {
  const _$AddressStateImpl({
    this.isLoading = false,
    this.isSuccess = false,
    this.apiErrorMessage = '',
    final List<AddressModel> addresses = const [],
    this.selectedAddress,
  }) : _addresses = addresses;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSuccess;
  @override
  @JsonKey()
  final String apiErrorMessage;
  final List<AddressModel> _addresses;
  @override
  @JsonKey()
  List<AddressModel> get addresses {
    if (_addresses is EqualUnmodifiableListView) return _addresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addresses);
  }

  @override
  final AddressModel? selectedAddress;

  @override
  String toString() {
    return 'AddressState(isLoading: $isLoading, isSuccess: $isSuccess, apiErrorMessage: $apiErrorMessage, addresses: $addresses, selectedAddress: $selectedAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.apiErrorMessage, apiErrorMessage) ||
                other.apiErrorMessage == apiErrorMessage) &&
            const DeepCollectionEquality().equals(
              other._addresses,
              _addresses,
            ) &&
            (identical(other.selectedAddress, selectedAddress) ||
                other.selectedAddress == selectedAddress));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isSuccess,
    apiErrorMessage,
    const DeepCollectionEquality().hash(_addresses),
    selectedAddress,
  );

  /// Create a copy of AddressState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressStateImplCopyWith<_$AddressStateImpl> get copyWith =>
      __$$AddressStateImplCopyWithImpl<_$AddressStateImpl>(this, _$identity);
}

abstract class _AddressState implements AddressState {
  const factory _AddressState({
    final bool isLoading,
    final bool isSuccess,
    final String apiErrorMessage,
    final List<AddressModel> addresses,
    final AddressModel? selectedAddress,
  }) = _$AddressStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isSuccess;
  @override
  String get apiErrorMessage;
  @override
  List<AddressModel> get addresses;
  @override
  AddressModel? get selectedAddress;

  /// Create a copy of AddressState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressStateImplCopyWith<_$AddressStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
