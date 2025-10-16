// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PaymentState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;
  String get apiErrorMessage => throw _privateConstructorUsedError;
  List<CardModel> get cards => throw _privateConstructorUsedError;
  CardModel? get selectedCard => throw _privateConstructorUsedError;

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentStateCopyWith<PaymentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentStateCopyWith<$Res> {
  factory $PaymentStateCopyWith(
    PaymentState value,
    $Res Function(PaymentState) then,
  ) = _$PaymentStateCopyWithImpl<$Res, PaymentState>;
  @useResult
  $Res call({
    bool isLoading,
    bool isSuccess,
    String apiErrorMessage,
    List<CardModel> cards,
    CardModel? selectedCard,
  });

  $CardModelCopyWith<$Res>? get selectedCard;
}

/// @nodoc
class _$PaymentStateCopyWithImpl<$Res, $Val extends PaymentState>
    implements $PaymentStateCopyWith<$Res> {
  _$PaymentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSuccess = null,
    Object? apiErrorMessage = null,
    Object? cards = null,
    Object? selectedCard = freezed,
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
            cards: null == cards
                ? _value.cards
                : cards // ignore: cast_nullable_to_non_nullable
                      as List<CardModel>,
            selectedCard: freezed == selectedCard
                ? _value.selectedCard
                : selectedCard // ignore: cast_nullable_to_non_nullable
                      as CardModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CardModelCopyWith<$Res>? get selectedCard {
    if (_value.selectedCard == null) {
      return null;
    }

    return $CardModelCopyWith<$Res>(_value.selectedCard!, (value) {
      return _then(_value.copyWith(selectedCard: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PaymentStateImplCopyWith<$Res>
    implements $PaymentStateCopyWith<$Res> {
  factory _$$PaymentStateImplCopyWith(
    _$PaymentStateImpl value,
    $Res Function(_$PaymentStateImpl) then,
  ) = __$$PaymentStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    bool isSuccess,
    String apiErrorMessage,
    List<CardModel> cards,
    CardModel? selectedCard,
  });

  @override
  $CardModelCopyWith<$Res>? get selectedCard;
}

/// @nodoc
class __$$PaymentStateImplCopyWithImpl<$Res>
    extends _$PaymentStateCopyWithImpl<$Res, _$PaymentStateImpl>
    implements _$$PaymentStateImplCopyWith<$Res> {
  __$$PaymentStateImplCopyWithImpl(
    _$PaymentStateImpl _value,
    $Res Function(_$PaymentStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSuccess = null,
    Object? apiErrorMessage = null,
    Object? cards = null,
    Object? selectedCard = freezed,
  }) {
    return _then(
      _$PaymentStateImpl(
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
        cards: null == cards
            ? _value._cards
            : cards // ignore: cast_nullable_to_non_nullable
                  as List<CardModel>,
        selectedCard: freezed == selectedCard
            ? _value.selectedCard
            : selectedCard // ignore: cast_nullable_to_non_nullable
                  as CardModel?,
      ),
    );
  }
}

/// @nodoc

class _$PaymentStateImpl implements _PaymentState {
  const _$PaymentStateImpl({
    this.isLoading = false,
    this.isSuccess = false,
    this.apiErrorMessage = '',
    final List<CardModel> cards = const [],
    this.selectedCard,
  }) : _cards = cards;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSuccess;
  @override
  @JsonKey()
  final String apiErrorMessage;
  final List<CardModel> _cards;
  @override
  @JsonKey()
  List<CardModel> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  final CardModel? selectedCard;

  @override
  String toString() {
    return 'PaymentState(isLoading: $isLoading, isSuccess: $isSuccess, apiErrorMessage: $apiErrorMessage, cards: $cards, selectedCard: $selectedCard)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.apiErrorMessage, apiErrorMessage) ||
                other.apiErrorMessage == apiErrorMessage) &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            (identical(other.selectedCard, selectedCard) ||
                other.selectedCard == selectedCard));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isSuccess,
    apiErrorMessage,
    const DeepCollectionEquality().hash(_cards),
    selectedCard,
  );

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentStateImplCopyWith<_$PaymentStateImpl> get copyWith =>
      __$$PaymentStateImplCopyWithImpl<_$PaymentStateImpl>(this, _$identity);
}

abstract class _PaymentState implements PaymentState {
  const factory _PaymentState({
    final bool isLoading,
    final bool isSuccess,
    final String apiErrorMessage,
    final List<CardModel> cards,
    final CardModel? selectedCard,
  }) = _$PaymentStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isSuccess;
  @override
  String get apiErrorMessage;
  @override
  List<CardModel> get cards;
  @override
  CardModel? get selectedCard;

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentStateImplCopyWith<_$PaymentStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
