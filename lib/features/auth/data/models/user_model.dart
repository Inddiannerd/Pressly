import '../../domain/entities/user.dart';

class UserModel {
  final String id;
  final String email;
  final String role;
  final String? name;
  final String? phoneNumber;
  final String? photoUrl;
  final bool isEmailVerified;
  final DateTime? createdAt;

  const UserModel({
    required this.id,
    required this.email,
    required this.role,
    this.name,
    this.phoneNumber,
    this.photoUrl,
    this.isEmailVerified = false,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['uid'] ?? json['id'] ?? '') as String,
      email: json['email'] as String,
      role: json['role'] as String? ?? 'customer',
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      photoUrl: json['photoUrl'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': id,
      'email': email,
      'role': role,
      'name': name,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'isEmailVerified': isEmailVerified,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      role: role,
      name: name,
      phoneNumber: phoneNumber,
      photoUrl: photoUrl,
      isEmailVerified: isEmailVerified,
      createdAt: createdAt,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      role: entity.role,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
      photoUrl: entity.photoUrl,
      isEmailVerified: entity.isEmailVerified,
      createdAt: entity.createdAt,
    );
  }
}
