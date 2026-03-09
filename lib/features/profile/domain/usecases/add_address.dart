import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/address.dart';
import '../repositories/address_repository.dart';

class AddAddress {
  final AddressRepository repository;

  AddAddress(this.repository);

  Future<Either<Failure, void>> call(AddressEntity address) async {
    return await repository.addAddress(address);
  }
}
