import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  });

  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    String? name,
  });

  Future<UserModel> signInWithOtp({
    required String verificationId,
    required String smsCode,
  });

  Future<String> sendOtp({
    required String phoneNumber,
  });

  Future<void> signOut();

  Future<UserModel?> getCurrentUser();

  User? get currentFirebaseUser;

  Stream<UserModel?> watchAuthState();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDataSourceImpl({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user!;
      return UserModel(
        id: user.uid,
        email: user.email!,
        role: 'customer',
        name: user.displayName,
        photoUrl: user.photoURL,
        isEmailVerified: user.emailVerified,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Authentication failed');
    }
  }

  @override
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user!;
      
      if (name != null) {
        await user.updateDisplayName(name);
      }
      
      return UserModel(
        id: user.uid,
        email: user.email!,
        role: 'customer',
        name: name ?? user.displayName,
        photoUrl: user.photoURL,
        isEmailVerified: user.emailVerified,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Registration failed');
    }
  }

  @override
  Future<UserModel> signInWithOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user!;
      return UserModel(
        id: user.uid,
        email: user.email ?? '',
        role: 'customer',
        name: user.displayName,
        phoneNumber: user.phoneNumber,
        photoUrl: user.photoURL,
        isEmailVerified: user.emailVerified,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'OTP verification failed');
    }
  }

  @override
  Future<String> sendOtp({
    required String phoneNumber,
  }) async {
    throw UnimplementedError('sendOtp should be handled via verifyPhoneNumber');
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return UserModel(
      id: user.uid,
      email: user.email!,
      role: 'customer',
      name: user.displayName,
      phoneNumber: user.phoneNumber,
      photoUrl: user.photoURL,
      isEmailVerified: user.emailVerified,
    );
  }

  @override
  User? get currentFirebaseUser => _firebaseAuth.currentUser;

  @override
  Stream<UserModel?> watchAuthState() {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user == null) return null;
      return UserModel(
        id: user.uid,
        email: user.email!,
        role: 'customer',
        name: user.displayName,
        phoneNumber: user.phoneNumber,
        photoUrl: user.photoURL,
        isEmailVerified: user.emailVerified,
      );
    });
  }
}
