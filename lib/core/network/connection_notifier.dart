import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisansarthi/core/config/env_config.dart';
import 'package:kisansarthi/core/network/dio_client.dart';
import 'package:kisansarthi/core/storage/storage_service.dart';
import 'dart:developer' as dev;

enum ConnectionStatus { idle, connecting, connected, failed }

class ConnectionState {
  final ConnectionStatus status;
  final String? message;
  final String? currentIp;

  ConnectionState({required this.status, this.message, this.currentIp});

  factory ConnectionState.initial() => ConnectionState(status: ConnectionStatus.idle);
}

final connectionNotifierProvider = StateNotifierProvider<ConnectionNotifier, ConnectionState>((ref) {
  return ConnectionNotifier(ref);
});

class ConnectionNotifier extends StateNotifier<ConnectionState> {
  final Ref _ref;

  ConnectionNotifier(this._ref) : super(ConnectionState.initial()) {
    _loadInitial();
  }

  void _loadInitial() {
    if (EnvConfig.isConfigured) {
      final uri = Uri.tryParse(EnvConfig.apiBaseUrl);
      state = ConnectionState(
        status: ConnectionStatus.connected,
        currentIp: uri?.host,
      );
    }
  }

  Future<void> connect(String ip) async {
    if (ip.isEmpty) return;
    
    state = ConnectionState(status: ConnectionStatus.connecting, currentIp: ip);
    
    try {
      String testUrl = ip;
      if (!testUrl.startsWith('http')) testUrl = 'http://$testUrl';
      if (!testUrl.contains(':5000')) testUrl = '$testUrl:5000';
      
      dev.log('Testing connection to: $testUrl', name: 'ConnectionNotifier');
      
      final dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ));
      
      final response = await dio.get(testUrl);

      if (response.statusCode == 200) {
        // Update Config
        EnvConfig.updateBaseUrl(ip);
        
        // Save to Storage
        await _ref.read(storageServiceProvider).saveBackendIp(ip);
        
        // Trigger Dio Refresh
        _ref.read(baseUrlProvider.notifier).state = EnvConfig.apiBaseUrl;
        
        state = ConnectionState(
          status: ConnectionStatus.connected,
          message: 'Connected ✅',
          currentIp: ip,
        );
      } else {
        throw Exception('Server returned ${response.statusCode}');
      }
    } catch (e) {
      dev.log('Connection failed: $e', name: 'ConnectionNotifier');
      state = ConnectionState(
        status: ConnectionStatus.failed,
        message: 'Connection failed ❌',
        currentIp: ip,
      );
    }
  }
}
