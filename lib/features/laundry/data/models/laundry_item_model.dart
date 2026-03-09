import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/laundry_item.dart';

class LaundryItemModel {
  final String id;
  final String name;
  final double price;

  const LaundryItemModel({
    required this.id,
    required this.name,
    required this.price,
  });

  factory LaundryItemModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return LaundryItemModel(
      id: doc.id,
      name: data['name'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'price': price,
    };
  }

  factory LaundryItemModel.fromEntity(LaundryItemEntity entity) {
    return LaundryItemModel(
      id: entity.id,
      name: entity.name,
      price: entity.price,
    );
  }

  LaundryItemEntity toEntity() {
    return LaundryItemEntity(
      id: id,
      name: name,
      price: price,
    );
  }
}
