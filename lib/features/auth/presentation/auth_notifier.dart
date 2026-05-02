import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisansarthi/core/network/api_utils.dart';
import 'package:kisansarthi/core/network/dio_client.dart';
import 'package:kisansarthi/core/storage/storage_service.dart';
import 'package:kisansarthi/features/auth/data/auth_repository_impl.dart';
import 'package:kisansarthi/features/auth/domain/auth_repository.dart';
import 'package:kisansarthi/features/auth/presentation/auth_state.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final storage = ref.watch(storageServiceProvider);
  return AuthRepositoryImpl(dio, storage);
});

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AuthState.initial()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    state = const AuthState.loading();
    try {
      final user = await _repository.getCurrentUser();
      state = AuthState.authenticated(user);
    } catch (e) {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> login(String identifier, String password) async {
    if (identifier.isEmpty || password.isEmpty) {
      state = const AuthState.error("Phone/Email and Password are required");
      return;
    }
    
    state = const AuthState.loading();
    try {
      await _repository.login(identifier, password);
      final fullUser = await _repository.getCurrentUser();
      state = AuthState.authenticated(fullUser);
    } catch (e) {
      String errorMessage = "Login failed";
      if (e is DioException) {
        errorMessage = ApiUtils.readErrorMessage(e) ?? errorMessage;
      }
      state = AuthState.error(errorMessage);
    }
  }

  Future<void> register({
    required String name,
    String? phone,
    String? email,
    required String password,
  }) async {
    if (name.isEmpty || password.isEmpty) {
      state = const AuthState.error("Name and Password are required");
      return;
    }
    
    state = const AuthState.loading();
    try {
      await _repository.register(
        name: name,
        phone: phone,
        email: email,
        password: password,
      );
      final fullUser = await _repository.getCurrentUser();
      state = AuthState.authenticated(fullUser);
    } catch (e) {
      String errorMessage = "Registration failed";
      if (e is DioException) {
        errorMessage = ApiUtils.readErrorMessage(e) ?? errorMessage;
      }
      state = AuthState.error(errorMessage);
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = const AuthState.unauthenticated();
  }
}
