import 'package:flutter/foundation.dart';
import 'package:kisansarthi/core/storage/storage_service.dart';
import 'dart:developer' as dev;

class EnvConfig {
  static bool useMock = false;

  static String? _apiBaseUrl;

  static String get apiBaseUrl => _apiBaseUrl ?? '';
  
  static bool get isConfigured => _apiBaseUrl != null && _apiBaseUrl!.isNotEmpty;

  static const int requestTimeoutMs = 30000;

  /// Returns the appropriate default host based on runtime platform
  static String getDefaultHost() {
    if (kIsWeb) {
      return '127.0.0.1';
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        // 10.0.2.2 reaches host machine from Android Emulator.
        // For physical device via USB, run `adb reverse tcp:5000 tcp:5000` and use 127.0.0.1.
        return '10.0.2.2';
      case TargetPlatform.iOS:
      case TargetPlatform.windows:
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        return '127.0.0.1';
    }
  }

  static void updateBaseUrl(String ip) {
    final cleanIp = ip.trim();
    if (cleanIp.isEmpty) {
      _apiBaseUrl = null;
      return;
    }

    String formatted = cleanIp;
    if (!formatted.startsWith('http://') && !formatted.startsWith('https://')) {
      formatted = 'http://$formatted';
    }
    
    while (formatted.endsWith('/')) {
      formatted = formatted.substring(0, formatted.length - 1);
    }
    
    if (formatted.endsWith('/api/v1')) {
      formatted = formatted.substring(0, formatted.length - 7);
    }

    if (!RegExp(r':\d+$').hasMatch(formatted)) {
      formatted = '$formatted:5000';
    }

    _apiBaseUrl = '$formatted/api/v1';
    useMock = false; 
    
    dev.log('API Base URL set to: $_apiBaseUrl', name: 'EnvConfig');
  }

  static Future<void> init(StorageService storageService) async {
    final savedIp = await storageService.getBackendIp();
    if (savedIp != null && savedIp.trim().isNotEmpty) {
      updateBaseUrl(savedIp);
    } else {
      updateBaseUrl(getDefaultHost());
    }
  }
}
