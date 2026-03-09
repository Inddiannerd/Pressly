import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/address.dart';
import '../../domain/usecases/add_address.dart';
import '../../domain/usecases/update_address.dart';
import 'address_providers.dart';

part 'address_form_provider.g.dart';

@riverpod
class AddressForm extends _$AddressForm {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<void> submitAddress({
    required AddressEntity address,
    required bool isEdit,
  }) async {
    state = const AsyncValue.loading();
    
    final repository = ref.read(addressRepositoryProvider);
    final result = isEdit 
        ? await UpdateAddress(repository).call(address)
        : await AddAddress(repository).call(address);

    result.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
      (_) {
        state = const AsyncValue.data(null);
        // Refresh the addresses list
        ref.invalidate(userAddressesProvider);
      },
    );
  }
}
