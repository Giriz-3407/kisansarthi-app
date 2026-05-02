import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisansarthi/core/config/env_config.dart';
import 'package:kisansarthi/core/storage/storage_service.dart';
import 'package:kisansarthi/features/auth/presentation/auth_notifier.dart';
import 'package:kisansarthi/features/auth/presentation/auth_state.dart';
import 'dart:developer' as dev;

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _ipController = TextEditingController();
  bool _isConnecting = false;

  @override
  void initState() {
    super.initState();
    _loadSavedIp();
  }

  Future<void> _loadSavedIp() async {
    final storage = ref.read(storageServiceProvider);
    final ip = await storage.getBackendIp();
    if (ip != null) {
      _ipController.text = ip;
    } else {
      // Use the default IP if nothing is saved
      _ipController.text = '10.53.179.109';
    }
  }

  Future<void> _connect() async {
    final ip = _ipController.text.trim();
    if (ip.isEmpty) return;

    setState(() => _isConnecting = true);

    try {
      // Prepare full URL for test call (checking root of the backend)
      String baseUrl = ip;
      if (!baseUrl.startsWith('http')) baseUrl = 'http://$baseUrl';
      if (!baseUrl.contains(':5000')) baseUrl = '$baseUrl:5000';
      
      dev.log('Testing connection to: $baseUrl', name: 'ProfileScreen');
      
      final dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ));
      
      // Perform the connection test
      final response = await dio.get(baseUrl);

      if (response.statusCode == 200) {
        // If successful, update config and save
        EnvConfig.updateBaseUrl(ip);
        await ref.read(storageServiceProvider).saveBackendIp(ip);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Connected ✅'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        throw Exception('Server returned ${response.statusCode}');
      }
    } catch (e) {
      dev.log('Connection failed: $e', name: 'ProfileScreen', error: e);
      String errorMsg = 'Connection failed ❌';
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout) errorMsg = 'Timeout ❌';
        else if (e.type == DioExceptionType.connectionError) errorMsg = 'Server unreachable ❌';
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isConnecting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            authState.maybeWhen(
              authenticated: (user) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person, size: 50),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildProfileItem('Name', user.name),
                  _buildProfileItem('Phone', user.phoneNumber ?? 'Not provided'),
                ],
              ),
              orElse: () => const Center(child: CircularProgressIndicator()),
            ),
            const SizedBox(height: 32),
            const Text('Backend Configuration', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Enter local IP address of your Flask server', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            TextField(
              controller: _ipController,
              decoration: const InputDecoration(
                labelText: 'Backend IP',
                hintText: 'e.g. 10.53.179.109',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isConnecting ? null : _connect,
                child: _isConnecting ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Connect'),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => ref.read(authNotifierProvider.notifier).logout(),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Divider(),
        ],
      ),
    );
  }
}
