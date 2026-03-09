import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  /// Signs in the user with email and password.
  Future<Either<Failure, UserEntity>> signInWithEmail({
    required String email,
    required String password,
  });

  /// Registers a new user with email, password, and optional name.
  Future<Either<Failure, UserEntity>> signUpWithEmail({
    required String email,
    required String password,
    String? name,
  });

  /// Signs in the user with an OTP (One-Time Password).
  /// [verificationId] is obtained after calling a send OTP method.
  Future<Either<Failure, UserEntity>> signInWithOtp({
    required String verificationId,
    required String smsCode,
  });

  /// Sends an OTP to the provided phone number.
  /// Returns a verification ID that must be used for [signInWithOtp].
  Future<Either<Failure, String>> sendOtp({
    required String phoneNumber,
  });

  /// Signs out the current user.
  Future<Either<Failure, void>> signOut();

  /// Gets the currently authenticated user, or null if no user is signed in.
  Future<Either<Failure, UserEntity?>> getCurrentUser();

  /// Streams the current authentication state.
  Stream<UserEntity?> watchAuthState();

  /// Fetches the user profile from Firestore.
  Future<Either<Failure, UserEntity>> getUserProfile(String uid);

  /// Streams the user profile from Firestore.
  Stream<UserEntity> watchUserProfile(String uid);

  /// Ensures that the user document exists in Firestore.
  Future<Either<Failure, void>> ensureUserExists(auth.User firebaseUser);
}
