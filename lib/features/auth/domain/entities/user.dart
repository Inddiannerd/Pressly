import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserEntity with _$UserEntity {
  const UserEntity._(); // Added this to allow adding methods

  const factory UserEntity({
    @JsonKey(name: 'uid') required String id,
    required String email,
    required String role,
    String? name,
    String? phoneNumber,
    String? photoUrl,
    @Default(false) bool isEmailVerified,
    DateTime? createdAt,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}
