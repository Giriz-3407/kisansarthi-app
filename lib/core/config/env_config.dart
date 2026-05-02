import 'package:kisansarthi/core/storage/storage_service.dart';
import 'dart:developer' as dev;

class EnvConfig {
  static bool useMock = false;

  // No default IP - user must connect first
  static String? _apiBaseUrl;

  static String get apiBaseUrl => _apiBaseUrl ?? '';
  
  static bool get isConfigured => _apiBaseUrl != null && _apiBaseUrl!.isNotEmpty;

  static const int requestTimeoutMs = 30000;

  static void updateBaseUrl(String ip) {
    if (ip.isEmpty) {
      _apiBaseUrl = null;
      return;
    }
    
    // Safety check: block emulator/localhost as per instructions
    if (ip == '10.0.2.2' || ip == '127.0.0.1' || ip == 'localhost') {
      dev.log('Blocking local/emulator IP: $ip', name: 'EnvConfig');
      return;
    }

    String formattedIp = ip;
    if (!formattedIp.startsWith('http')) {
      formattedIp = 'http://$formattedIp';
    }
    if (!formattedIp.contains(':5000')) {
      formattedIp = '$formattedIp:5000';
    }
    _apiBaseUrl = '$formattedIp/api/v1';
    useMock = false; 
    
    dev.log('API Base URL set to: $_apiBaseUrl', name: 'EnvConfig');
  }

  static Future<void> init(StorageService storageService) async {
    final savedIp = await storageService.getBackendIp();
    if (savedIp != null && savedIp.isNotEmpty && savedIp != '10.0.2.2') {
      updateBaseUrl(savedIp);
    }
  }
}
