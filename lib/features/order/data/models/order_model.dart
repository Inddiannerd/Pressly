import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_laundary/features/order/domain/entities/order.dart';

class OrderModel {
  final String id;
  final String userId;
  final String userEmail;
  final String addressId;
  final OrderStatus status;
  final DateTime createdAt;
  final double totalAmount;
  final Map<String, int> items;
  final String? addressLabel;
  final String? addressDetails;

  const OrderModel({
    required this.id,
    required this.userId,
    required this.userEmail,
    required this.addressId,
    required this.status,
    required this.createdAt,
    required this.totalAmount,
    this.items = const {},
    this.addressLabel,
    this.addressDetails,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final statusStr = data['status'] as String;
    return OrderModel(
      id: doc.id,
      userId: data['userId'] as String,
      userEmail: data['userEmail'] as String? ?? 'N/A',
      addressId: data['addressId'] as String,
      status: OrderStatus.values.firstWhere(
        (e) {
          // Check against enum name or common variants
          final name = e.name;
          return name == statusStr || name.replaceAll('_', '') == statusStr.replaceAll('_', '');
        },
        orElse: () => OrderStatus.pending,
      ),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      totalAmount: (data['totalAmount'] as num).toDouble(),
      items: Map<String, int>.from(data['items'] ?? {}),
      addressLabel: data['addressLabel'] as String?,
      addressDetails: data['addressDetails'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'userEmail': userEmail,
      'addressId': addressId,
      'status': status.name,
      'createdAt': Timestamp.fromDate(createdAt),
      'totalAmount': totalAmount,
      'items': items,
      'addressLabel': addressLabel,
      'addressDetails': addressDetails,
    };
  }

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      id: entity.id,
      userId: entity.userId,
      userEmail: entity.userEmail,
      addressId: entity.addressId,
      status: entity.status,
      createdAt: entity.createdAt,
      totalAmount: entity.totalAmount,
      items: entity.items,
      addressLabel: entity.addressLabel,
      addressDetails: entity.addressDetails,
    );
  }

  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      userId: userId,
      userEmail: userEmail,
      addressId: addressId,
      status: status,
      createdAt: createdAt,
      totalAmount: totalAmount,
      items: items,
      addressLabel: addressLabel,
      addressDetails: addressDetails,
    );
  }
}
