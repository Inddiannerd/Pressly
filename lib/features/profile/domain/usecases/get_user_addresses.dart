import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/address.dart';
import '../repositories/address_repository.dart';

class GetUserAddresses {
  final AddressRepository repository;

  GetUserAddresses(this.repository);

  Future<Either<Failure, List<AddressEntity>>> call(String userId) async {
    return await repository.getUserAddresses(userId);
  }
}
