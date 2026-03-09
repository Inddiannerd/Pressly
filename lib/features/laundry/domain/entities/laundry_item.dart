import 'package:freezed_annotation/freezed_annotation.dart';

part 'laundry_item.freezed.dart';

@freezed
class LaundryItemEntity with _$LaundryItemEntity {
  const factory LaundryItemEntity({
    required String id,
    required String name,
    required double price,
  }) = _LaundryItemEntity;
}
