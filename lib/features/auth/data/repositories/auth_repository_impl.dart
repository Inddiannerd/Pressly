import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../datasources/user_firestore_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final UserFirestoreDataSource userFirestoreDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.userFirestoreDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await remoteDataSource.signInWithEmail(
        email: email,
        password: password,
      );
      
      final firebaseUser = remoteDataSource.currentFirebaseUser;
      if (firebaseUser != null) {
        await ensureUserExists(firebaseUser);
      }
      
      return Right(userModel.toEntity());
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmail({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      final userModel = await remoteDataSource.signUpWithEmail(
        email: email,
        password: password,
        name: name,
      );

      final firebaseUser = remoteDataSource.currentFirebaseUser;
      if (firebaseUser != null) {
        await ensureUserExists(firebaseUser);
      }

      return Right(userModel.toEntity());
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final userModel = await remoteDataSource.signInWithOtp(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      final firebaseUser = remoteDataSource.currentFirebaseUser;
      if (firebaseUser != null) {
        await ensureUserExists(firebaseUser);
      }

      return Right(userModel.toEntity());
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> sendOtp({
    required String phoneNumber,
  }) async {
    try {
      final verificationId = await remoteDataSource.sendOtp(
        phoneNumber: phoneNumber,
      );
      return Right(verificationId);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      if (userModel != null) {
        final firebaseUser = remoteDataSource.currentFirebaseUser;
        if (firebaseUser != null) {
          await ensureUserExists(firebaseUser);
        }
      }
      return Right(userModel?.toEntity());
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Stream<UserEntity?> watchAuthState() {
    return remoteDataSource.watchAuthState().map(
          (userModel) => userModel?.toEntity(),
        );
  }

  @override
  Future<Either<Failure, UserEntity>> getUserProfile(String uid) async {
    try {
      final userModel = await userFirestoreDataSource.fetchUser(uid);
      return Right(userModel.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<UserEntity> watchUserProfile(String uid) {
    return userFirestoreDataSource.watchUser(uid).map((model) => model.toEntity());
  }

  @override
  Future<Either<Failure, void>> ensureUserExists(auth.User firebaseUser) async {
    try {
      await userFirestoreDataSource.createUserIfMissing(firebaseUser);
      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
