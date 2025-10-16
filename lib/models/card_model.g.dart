// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CardModelImpl _$$CardModelImplFromJson(Map<String, dynamic> json) =>
    _$CardModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      cardNumber: json['cardNumber'] as String,
      cardholderName: json['cardholderName'] as String,
      expiryDate: json['expiryDate'] as String,
      cvv: json['cvv'] as String,
      cardType: json['cardType'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
    );

Map<String, dynamic> _$$CardModelImplToJson(_$CardModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'cardNumber': instance.cardNumber,
      'cardholderName': instance.cardholderName,
      'expiryDate': instance.expiryDate,
      'cvv': instance.cvv,
      'cardType': instance.cardType,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'isDefault': instance.isDefault,
    };
