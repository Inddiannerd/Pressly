// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressEntityImpl _$$AddressEntityImplFromJson(Map<String, dynamic> json) =>
    _$AddressEntityImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      label: json['label'] as String,
      addressLine1: json['addressLine1'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      country: json['country'] as String,
      landmark: json['landmark'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$AddressEntityImplToJson(_$AddressEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'label': instance.label,
      'addressLine1': instance.addressLine1,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
      'country': instance.country,
      'landmark': instance.landmark,
      'isDefault': instance.isDefault,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
