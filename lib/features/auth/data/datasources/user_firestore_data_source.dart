import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../models/user_model.dart';

abstract class UserFirestoreDataSource {
  Future<UserModel> fetchUser(String uid);
  Stream<UserModel> watchUser(String uid);
  Future<void> createUserIfMissing(auth.User firebaseUser);
}

class UserFirestoreDataSourceImpl implements UserFirestoreDataSource {
  final FirebaseFirestore _firestore;

  UserFirestoreDataSourceImpl(this._firestore);

  @override
  Future<UserModel> fetchUser(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists) {
      throw Exception('User profile not found');
    }
    return UserModel.fromJson(doc.data()!);
  }

  @override
  Stream<UserModel> watchUser(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map((doc) {
      if (!doc.exists) {
        throw Exception('User profile not found');
      }
      return UserModel.fromJson(doc.data()!);
    });
  }

  @override
  Future<void> createUserIfMissing(auth.User firebaseUser) async {
    final userDoc = _firestore.collection('users').doc(firebaseUser.uid);
    final doc = await userDoc.get();

    final expectedRole = firebaseUser.email == 'vanshpatel29626@gmail.com' ? 'admin' : 'customer';

    if (!doc.exists) {
      final userModel = UserModel(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        role: expectedRole,
        name: firebaseUser.displayName,
        photoUrl: firebaseUser.photoURL,
        phoneNumber: firebaseUser.phoneNumber,
        isEmailVerified: firebaseUser.emailVerified,
        createdAt: DateTime.now(),
      );
      await userDoc.set(userModel.toJson());
    } else {
      final data = doc.data() as Map<String, dynamic>;
      final currentRole = data['role'] as String?;
      
      if (currentRole != expectedRole) {
        await userDoc.update({'role': expectedRole});
      }
    }
  }
}
