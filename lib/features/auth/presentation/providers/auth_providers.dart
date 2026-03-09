import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/providers/firebase_providers.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/user_firestore_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/sign_in_with_email.dart';
import '../../domain/usecases/sign_up_with_email.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  return AuthRemoteDataSourceImpl(
    firebaseAuth: ref.watch(firebaseAuthProvider),
  );
}

@riverpod
UserFirestoreDataSource userFirestoreDataSource(UserFirestoreDataSourceRef ref) {
  return UserFirestoreDataSourceImpl(ref.watch(firestoreProvider));
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    userFirestoreDataSource: ref.watch(userFirestoreDataSourceProvider),
  );
}

@riverpod
SignInWithEmail signInWithEmailUseCase(SignInWithEmailUseCaseRef ref) {
  return SignInWithEmail(ref.watch(authRepositoryProvider));
}

@riverpod
SignUpWithEmail signUpWithEmailUseCase(SignUpWithEmailUseCaseRef ref) {
  return SignUpWithEmail(ref.watch(authRepositoryProvider));
}

@riverpod
Stream<auth.User?> authState(AuthStateRef ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
}

@riverpod
Stream<UserEntity?> userProfile(UserProfileRef ref) {
  final authStateAsync = ref.watch(authStateProvider);
  
  return authStateAsync.when(
    data: (firebaseUser) {
      if (firebaseUser == null) return Stream.value(null);
      
      final repository = ref.watch(authRepositoryProvider);
      return repository.watchUserProfile(firebaseUser.uid);
    },
    loading: () => Stream.value(null),
    error: (err, stack) => Stream.error(err, stack),
  );
}

@riverpod
Stream<String> userRole(UserRoleRef ref) {
  final userProfileAsync = ref.watch(userProfileProvider);
  
  return userProfileAsync.when(
    data: (user) => Stream.value(user?.role ?? 'customer'),
    loading: () => Stream.value('customer'),
    error: (err, stack) => Stream.value('customer'),
  );
}
