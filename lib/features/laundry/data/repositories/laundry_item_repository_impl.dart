import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/laundry_item.dart';
import '../../domain/repositories/laundry_item_repository.dart';
import '../models/laundry_item_model.dart';

class LaundryItemRepositoryImpl implements LaundryItemRepository {
  final FirebaseFirestore _firestore;

  LaundryItemRepositoryImpl(this._firestore);

  CollectionReference get _collection => _firestore.collection('laundry_items');

  @override
  Stream<List<LaundryItemEntity>> getLaundryItems() {
    return _collection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => LaundryItemModel.fromFirestore(doc).toEntity())
          .toList();
    });
  }

  @override
  Future<void> addLaundryItem(LaundryItemEntity item) {
    return _collection.doc(item.id).set(LaundryItemModel.fromEntity(item).toFirestore());
  }

  @override
  Future<void> updateLaundryItem(LaundryItemEntity item) {
    return _collection.doc(item.id).update(LaundryItemModel.fromEntity(item).toFirestore());
  }

  @override
  Future<void> deleteLaundryItem(String id) {
    return _collection.doc(id).delete();
  }
}
