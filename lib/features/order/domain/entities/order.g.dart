// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderEntityImpl _$$OrderEntityImplFromJson(Map<String, dynamic> json) =>
    _$OrderEntityImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userEmail: json['userEmail'] as String,
      addressId: json['addressId'] as String,
      status: $enumDecode(_$OrderStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      items: (json['items'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      addressLabel: json['addressLabel'] as String?,
      addressDetails: json['addressDetails'] as String?,
    );

Map<String, dynamic> _$$OrderEntityImplToJson(_$OrderEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userEmail': instance.userEmail,
      'addressId': instance.addressId,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'totalAmount': instance.totalAmount,
      'items': instance.items,
      'addressLabel': instance.addressLabel,
      'addressDetails': instance.addressDetails,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.picked_up: 'picked_up',
  OrderStatus.washing: 'washing',
  OrderStatus.ironing: 'ironing',
  OrderStatus.out_for_delivery: 'out_for_delivery',
  OrderStatus.completed: 'completed',
  OrderStatus.cancelled: 'cancelled',
};
