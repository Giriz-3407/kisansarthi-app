import 'package:kisansarthi/shared/models/auth_response.dart';
import 'package:kisansarthi/shared/models/user.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(String identifier, String password);
  Future<AuthResponse> register({
    required String name,
    String? phone,
    String? email,
    required String password,
  });
  Future<User> getCurrentUser();
  Future<void> logout();
}
