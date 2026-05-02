import 'package:dio/dio.dart';
import 'package:kisansarthi/core/network/api_utils.dart';
import 'package:kisansarthi/features/auth/domain/auth_repository.dart';
import 'package:kisansarthi/shared/models/auth_response.dart';
import 'package:kisansarthi/shared/models/user.dart';
import 'package:kisansarthi/core/storage/storage_service.dart';
import 'dart:developer' as dev;

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;
  final StorageService _storageService;

  AuthRepositoryImpl(this._dio, this._storageService);

  @override
  Future<AuthResponse> login(String identifier, String password) async {
    final Map<String, dynamic> data = {
      'email_or_phone': identifier,
      'password': password,
    };
    
    dev.log("LOGIN PAYLOAD: $data", name: 'AuthRepository');

    try {
      final response = await _dio.post(
        '/auth/login', 
        data: data,
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );
      final authResponse = AuthResponse.fromJson(ApiUtils.extractMap(response.data));
      await _storageService.saveToken(authResponse.token);
      return authResponse;
    } catch (e) {
      if (e is DioException) {
        dev.log("LOGIN ERROR DATA: ${e.response?.data}", name: 'AuthRepository');
      }
      rethrow;
    }
  }

  @override
  Future<AuthResponse> register({
    required String name,
    String? phone,
    String? email,
    required String password,
  }) async {
    final Map<String, dynamic> data = {
      'name': name,
      'password': password,
    };
    if (phone != null && phone.isNotEmpty) data['phone_number'] = phone;
    // Backend register currently ignores email; keep it out to avoid 400/assumption mismatch.

    dev.log("REGISTER PAYLOAD: $data", name: 'AuthRepository');

    try {
      final response = await _dio.post(
        '/auth/register', 
        data: data,
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );
      final authResponse = AuthResponse.fromJson(ApiUtils.extractMap(response.data));
      await _storageService.saveToken(authResponse.token);
      return authResponse;
    } catch (e) {
      if (e is DioException) {
        dev.log("REGISTER ERROR DATA: ${e.response?.data}", name: 'AuthRepository');
      }
      rethrow;
    }
  }

  @override
  Future<User> getCurrentUser() async {
    try {
      final response = await _dio.get('/users/me');
      return User.fromJson(ApiUtils.extractMap(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await _storageService.deleteToken();
    await _storageService.clearAll();
  }
}
