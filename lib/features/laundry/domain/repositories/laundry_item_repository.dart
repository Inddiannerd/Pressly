import '../../domain/entities/laundry_item.dart';

abstract class LaundryItemRepository {
  Stream<List<LaundryItemEntity>> getLaundryItems();
  Future<void> addLaundryItem(LaundryItemEntity item);
  Future<void> updateLaundryItem(LaundryItemEntity item);
  Future<void> deleteLaundryItem(String id);
}
