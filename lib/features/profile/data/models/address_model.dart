import '../../domain/entities/address.dart';

class AddressModel {
  final String id;
  final String userId;
  final String label;
  final String addressLine1;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final String? landmark;
  final bool isDefault;
  final double? latitude;
  final double? longitude;

  const AddressModel({
    required this.id,
    required this.userId,
    required this.label,
    required this.addressLine1,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    this.landmark,
    this.isDefault = false,
    this.latitude,
    this.longitude,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
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
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'label': label,
      'addressLine1': addressLine1,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'country': country,
      'landmark': landmark,
      'isDefault': isDefault,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  AddressEntity toEntity() {
    return AddressEntity(
      id: id,
      userId: userId,
      label: label,
      addressLine1: addressLine1,
      city: city,
      state: state,
      zipCode: zipCode,
      country: country,
      landmark: landmark,
      isDefault: isDefault,
      latitude: latitude,
      longitude: longitude,
    );
  }

  factory AddressModel.fromEntity(AddressEntity e) {
    return AddressModel(
      id: e.id,
      userId: e.userId,
      label: e.label,
      addressLine1: e.addressLine1,
      city: e.city,
      state: e.state,
      zipCode: e.zipCode,
      country: e.country,
      landmark: e.landmark,
      isDefault: e.isDefault,
      latitude: e.latitude,
      longitude: e.longitude,
    );
  }
}
