// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderEntity _$OrderEntityFromJson(Map<String, dynamic> json) {
  return _OrderEntity.fromJson(json);
}

/// @nodoc
mixin _$OrderEntity {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get userEmail => throw _privateConstructorUsedError;
  String get addressId => throw _privateConstructorUsedError;
  OrderStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  Map<String, int> get items => throw _privateConstructorUsedError;
  String? get addressLabel => throw _privateConstructorUsedError;
  String? get addressDetails => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderEntityCopyWith<OrderEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderEntityCopyWith<$Res> {
  factory $OrderEntityCopyWith(
          OrderEntity value, $Res Function(OrderEntity) then) =
      _$OrderEntityCopyWithImpl<$Res, OrderEntity>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String userEmail,
      String addressId,
      OrderStatus status,
      DateTime createdAt,
      double totalAmount,
      Map<String, int> items,
      String? addressLabel,
      String? addressDetails});
}

/// @nodoc
class _$OrderEntityCopyWithImpl<$Res, $Val extends OrderEntity>
    implements $OrderEntityCopyWith<$Res> {
  _$OrderEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userEmail = null,
    Object? addressId = null,
    Object? status = null,
    Object? createdAt = null,
    Object? totalAmount = null,
    Object? items = null,
    Object? addressLabel = freezed,
    Object? addressDetails = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userEmail: null == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String,
      addressId: null == addressId
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      addressLabel: freezed == addressLabel
          ? _value.addressLabel
          : addressLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      addressDetails: freezed == addressDetails
          ? _value.addressDetails
          : addressDetails // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderEntityImplCopyWith<$Res>
    implements $OrderEntityCopyWith<$Res> {
  factory _$$OrderEntityImplCopyWith(
          _$OrderEntityImpl value, $Res Function(_$OrderEntityImpl) then) =
      __$$OrderEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String userEmail,
      String addressId,
      OrderStatus status,
      DateTime createdAt,
      double totalAmount,
      Map<String, int> items,
      String? addressLabel,
      String? addressDetails});
}

/// @nodoc
class __$$OrderEntityImplCopyWithImpl<$Res>
    extends _$OrderEntityCopyWithImpl<$Res, _$OrderEntityImpl>
    implements _$$OrderEntityImplCopyWith<$Res> {
  __$$OrderEntityImplCopyWithImpl(
      _$OrderEntityImpl _value, $Res Function(_$OrderEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userEmail = null,
    Object? addressId = null,
    Object? status = null,
    Object? createdAt = null,
    Object? totalAmount = null,
    Object? items = null,
    Object? addressLabel = freezed,
    Object? addressDetails = freezed,
  }) {
    return _then(_$OrderEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userEmail: null == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String,
      addressId: null == addressId
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      addressLabel: freezed == addressLabel
          ? _value.addressLabel
          : addressLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      addressDetails: freezed == addressDetails
          ? _value.addressDetails
          : addressDetails // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderEntityImpl extends _OrderEntity {
  const _$OrderEntityImpl(
      {required this.id,
      required this.userId,
      required this.userEmail,
      required this.addressId,
      required this.status,
      required this.createdAt,
      required this.totalAmount,
      final Map<String, int> items = const {},
      this.addressLabel,
      this.addressDetails})
      : _items = items,
        super._();

  factory _$OrderEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String userEmail;
  @override
  final String addressId;
  @override
  final OrderStatus status;
  @override
  final DateTime createdAt;
  @override
  final double totalAmount;
  final Map<String, int> _items;
  @override
  @JsonKey()
  Map<String, int> get items {
    if (_items is EqualUnmodifiableMapView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_items);
  }

  @override
  final String? addressLabel;
  @override
  final String? addressDetails;

  @override
  String toString() {
    return 'OrderEntity(id: $id, userId: $userId, userEmail: $userEmail, addressId: $addressId, status: $status, createdAt: $createdAt, totalAmount: $totalAmount, items: $items, addressLabel: $addressLabel, addressDetails: $addressDetails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.addressId, addressId) ||
                other.addressId == addressId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.addressLabel, addressLabel) ||
                other.addressLabel == addressLabel) &&
            (identical(other.addressDetails, addressDetails) ||
                other.addressDetails == addressDetails));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      userEmail,
      addressId,
      status,
      createdAt,
      totalAmount,
      const DeepCollectionEquality().hash(_items),
      addressLabel,
      addressDetails);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderEntityImplCopyWith<_$OrderEntityImpl> get copyWith =>
      __$$OrderEntityImplCopyWithImpl<_$OrderEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderEntityImplToJson(
      this,
    );
  }
}

abstract class _OrderEntity extends OrderEntity {
  const factory _OrderEntity(
      {required final String id,
      required final String userId,
      required final String userEmail,
      required final String addressId,
      required final OrderStatus status,
      required final DateTime createdAt,
      required final double totalAmount,
      final Map<String, int> items,
      final String? addressLabel,
      final String? addressDetails}) = _$OrderEntityImpl;
  const _OrderEntity._() : super._();

  factory _OrderEntity.fromJson(Map<String, dynamic> json) =
      _$OrderEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get userEmail;
  @override
  String get addressId;
  @override
  OrderStatus get status;
  @override
  DateTime get createdAt;
  @override
  double get totalAmount;
  @override
  Map<String, int> get items;
  @override
  String? get addressLabel;
  @override
  String? get addressDetails;
  @override
  @JsonKey(ignore: true)
  _$$OrderEntityImplCopyWith<_$OrderEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
