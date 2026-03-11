import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';
part 'order.g.dart';

enum OrderStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('picked_up')
  picked_up,
  @JsonValue('washing')
  washing,
  @JsonValue('ironing')
  ironing,
  @JsonValue('out_for_delivery')
  out_for_delivery,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}

@freezed
class OrderEntity with _$OrderEntity {
  const OrderEntity._();

  const factory OrderEntity({
    required String id,
    required String userId,
    required String userEmail,
    required String addressId,
    required OrderStatus status,
    required DateTime createdAt,
    required double totalAmount,
    @Default({}) Map<String, int> items,
    String? addressLabel,
    String? addressDetails,
  }) = _OrderEntity;

  factory OrderEntity.fromJson(Map<String, dynamic> json) =>
      _$OrderEntityFromJson(json);
}

