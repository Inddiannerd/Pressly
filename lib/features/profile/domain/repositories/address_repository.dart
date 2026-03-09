import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/address.dart';

abstract class AddressRepository {
  Future<Either<Failure, List<AddressEntity>>> getUserAddresses(String userId);
  Future<Either<Failure, void>> addAddress(AddressEntity address);
  Future<Either<Failure, void>> updateAddress(AddressEntity address);
  Future<Either<Failure, void>> deleteAddress(String addressId);
}
