// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'laundry_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LaundryItemEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LaundryItemEntityCopyWith<LaundryItemEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LaundryItemEntityCopyWith<$Res> {
  factory $LaundryItemEntityCopyWith(
          LaundryItemEntity value, $Res Function(LaundryItemEntity) then) =
      _$LaundryItemEntityCopyWithImpl<$Res, LaundryItemEntity>;
  @useResult
  $Res call({String id, String name, double price});
}

/// @nodoc
class _$LaundryItemEntityCopyWithImpl<$Res, $Val extends LaundryItemEntity>
    implements $LaundryItemEntityCopyWith<$Res> {
  _$LaundryItemEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LaundryItemEntityImplCopyWith<$Res>
    implements $LaundryItemEntityCopyWith<$Res> {
  factory _$$LaundryItemEntityImplCopyWith(_$LaundryItemEntityImpl value,
          $Res Function(_$LaundryItemEntityImpl) then) =
      __$$LaundryItemEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, double price});
}

/// @nodoc
class __$$LaundryItemEntityImplCopyWithImpl<$Res>
    extends _$LaundryItemEntityCopyWithImpl<$Res, _$LaundryItemEntityImpl>
    implements _$$LaundryItemEntityImplCopyWith<$Res> {
  __$$LaundryItemEntityImplCopyWithImpl(_$LaundryItemEntityImpl _value,
      $Res Function(_$LaundryItemEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
  }) {
    return _then(_$LaundryItemEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$LaundryItemEntityImpl implements _LaundryItemEntity {
  const _$LaundryItemEntityImpl(
      {required this.id, required this.name, required this.price});

  @override
  final String id;
  @override
  final String name;
  @override
  final double price;

  @override
  String toString() {
    return 'LaundryItemEntity(id: $id, name: $name, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LaundryItemEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, price);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LaundryItemEntityImplCopyWith<_$LaundryItemEntityImpl> get copyWith =>
      __$$LaundryItemEntityImplCopyWithImpl<_$LaundryItemEntityImpl>(
          this, _$identity);
}

abstract class _LaundryItemEntity implements LaundryItemEntity {
  const factory _LaundryItemEntity(
      {required final String id,
      required final String name,
      required final double price}) = _$LaundryItemEntityImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  double get price;
  @override
  @JsonKey(ignore: true)
  _$$LaundryItemEntityImplCopyWith<_$LaundryItemEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
