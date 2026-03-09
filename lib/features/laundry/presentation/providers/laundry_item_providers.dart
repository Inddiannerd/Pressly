import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_laundary/core/providers/firebase_providers.dart';
import '../../domain/entities/laundry_item.dart';
import '../../domain/repositories/laundry_item_repository.dart';
import '../../data/repositories/laundry_item_repository_impl.dart';

part 'laundry_item_providers.g.dart';

@riverpod
LaundryItemRepository laundryItemRepository(LaundryItemRepositoryRef ref) {
  final firestore = ref.watch(firestoreProvider);
  return LaundryItemRepositoryImpl(firestore);
}

@riverpod
Stream<List<LaundryItemEntity>> laundryItems(LaundryItemsRef ref) {
  final repository = ref.watch(laundryItemRepositoryProvider);
  return repository.getLaundryItems();
}

@riverpod
class LaundryItemController extends _$LaundryItemController {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> addItem(LaundryItemEntity item) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      final repository = ref.read(laundryItemRepositoryProvider);
      return repository.addLaundryItem(item);
    });
  }

  Future<void> updateItem(LaundryItemEntity item) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      final repository = ref.read(laundryItemRepositoryProvider);
      return repository.updateLaundryItem(item);
    });
  }

  Future<void> deleteItem(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      final repository = ref.read(laundryItemRepositoryProvider);
      return repository.deleteLaundryItem(id);
    });
  }
}
