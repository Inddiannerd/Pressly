import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/error/exceptions.dart';
import '../models/address_model.dart';

abstract class AddressRemoteDataSource {
  Future<List<AddressModel>> getUserAddresses(String userId);
  Future<void> addAddress(AddressModel address);
  Future<void> updateAddress(AddressModel address);
  Future<void> deleteAddress(String addressId);
}

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final FirebaseFirestore _firestore;

  AddressRemoteDataSourceImpl(this._firestore);

  @override
  Future<List<AddressModel>> getUserAddresses(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('addresses')
          .where('userId', isEqualTo: userId)
          .get();
      return snapshot.docs
          .map((doc) => AddressModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw ServerException('Failed to fetch addresses: ${e.toString()}');
    }
  }

  @override
  Future<void> addAddress(AddressModel address) async {
    try {
      await _firestore
          .collection('addresses')
          .doc(address.id)
          .set(address.toJson());
    } catch (e) {
      throw ServerException('Failed to add address: ${e.toString()}');
    }
  }

  @override
  Future<void> updateAddress(AddressModel address) async {
    try {
      await _firestore
          .collection('addresses')
          .doc(address.id)
          .update(address.toJson());
    } catch (e) {
      throw ServerException('Failed to update address: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    try {
      await _firestore.collection('addresses').doc(addressId).delete();
    } catch (e) {
      throw ServerException('Failed to delete address: ${e.toString()}');
    }
  }
}
