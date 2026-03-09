import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../providers/auth_providers.dart';

part 'auth_controller.freezed.dart';
part 'auth_controller.g.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _AuthState;
}

@riverpod
class AuthController extends _$AuthController {
  @override
  AuthState build() {
    return const AuthState();
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    final signInUseCase = ref.read(signInWithEmailUseCaseProvider);
    final result = await signInUseCase.call(email: email, password: password);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false, 
          errorMessage: failure.message,
        );
      },
      (user) {
        state = state.copyWith(isLoading: false);
      },
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
    String? name,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final signUpUseCase = ref.read(signUpWithEmailUseCaseProvider);
    final result = await signUpUseCase.call(
      email: email,
      password: password,
      name: name,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
      },
      (user) {
        state = state.copyWith(isLoading: false);
      },
    );
  }
}
