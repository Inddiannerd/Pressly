import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class AddressEntity with _$AddressEntity {
  const factory AddressEntity({
    required String id,
    required String userId,
    required String label,
    required String addressLine1,
    required String city,
    required String state,
    required String zipCode,
    required String country,
    String? landmark,
    @Default(false) bool isDefault,
    double? latitude,
    double? longitude,
  }) = _AddressEntity;

  factory AddressEntity.fromJson(Map<String, dynamic> json) =>
      _$AddressEntityFromJson(json);
}
