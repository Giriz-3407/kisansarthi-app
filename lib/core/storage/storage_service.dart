import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService(const FlutterSecureStorage());
});

class StorageService {
  final FlutterSecureStorage _secureStorage;
  static const String _tokenKey = 'auth_token';
  static const String _backendIpKey = 'backend_ip';

  StorageService(this._secureStorage);

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }

  Future<void> saveBackendIp(String ip) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_backendIpKey, ip);
  }

  Future<String?> getBackendIp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_backendIpKey);
  }

  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
    final prefs = await SharedPreferences.getInstance();
    final ip = prefs.getString(_backendIpKey);
    await prefs.clear();
    if (ip != null) await prefs.setString(_backendIpKey, ip); // Keep IP even on clear if desired, or fully clear.
  }
}
