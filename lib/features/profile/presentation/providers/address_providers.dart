import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/providers/firebase_providers.dart';
import '../../data/datasources/address_remote_data_source.dart';
import '../../data/repositories/address_repository_impl.dart';
import '../../domain/entities/address.dart';
import '../../domain/repositories/address_repository.dart';
import '../../domain/usecases/get_user_addresses.dart';

part 'address_providers.g.dart';

@riverpod
AddressRemoteDataSource addressRemoteDataSource(AddressRemoteDataSourceRef ref) {
  return AddressRemoteDataSourceImpl(ref.watch(firestoreProvider));
}

@riverpod
AddressRepository addressRepository(AddressRepositoryRef ref) {
  return AddressRepositoryImpl(ref.watch(addressRemoteDataSourceProvider));
}

@riverpod
Future<List<AddressEntity>> userAddresses(UserAddressesRef ref) async {
  // Assuming we have a way to get current userId. 
  // For now, let's use a placeholder or watch auth state if available.
  // In a real app, you'd watch the auth state provider.
  const userId = 'placeholder_user_id'; 
  final repository = ref.watch(addressRepositoryProvider);
  final result = await GetUserAddresses(repository).call(userId);
  
  return result.fold(
    (l) => throw Exception(l.message),
    (r) => r,
  );
}
