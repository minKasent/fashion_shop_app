// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressModelImpl _$$AddressModelImplFromJson(Map<String, dynamic> json) =>
    _$AddressModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      streetAddress: json['streetAddress'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
    );

Map<String, dynamic> _$$AddressModelImplToJson(_$AddressModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'streetAddress': instance.streetAddress,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'isDefault': instance.isDefault,
    };
