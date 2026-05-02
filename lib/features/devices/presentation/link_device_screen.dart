import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kisansarthi/core/network/dio_client.dart';
import 'package:kisansarthi/features/devices/data/device_repository_impl.dart';
import 'package:kisansarthi/features/devices/domain/device_repository.dart';

final deviceRepositoryProvider = Provider<DeviceRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return DeviceRepositoryImpl(dio);
});

class LinkDeviceScreen extends ConsumerStatefulWidget {
  final int? farmId;
  final int? landId;
  const LinkDeviceScreen({super.key, this.farmId, this.landId});

  @override
  ConsumerState<LinkDeviceScreen> createState() => _LinkDeviceScreenState();
}

class _LinkDeviceScreenState extends ConsumerState<LinkDeviceScreen> {
  final _serialController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submit() async {
    if (_serialController.text.isEmpty) return;
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(deviceRepositoryProvider);
      final farmId = widget.farmId;
      if (farmId == null) {
        throw Exception('Farm ID is required to register a hardware device.');
      }
      // First create/find device
      final device = await repo.createDevice(farmId, _serialController.text);
      // Then assign it
      await repo.assignDevice(device.id, farmId: widget.farmId, landId: widget.landId);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Device linked successfully!')));
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to link device: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Link Hardware Device')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Enter the serial number of your KisanSarthi IoT device to link it to this location.'),
            const SizedBox(height: 24),
            TextField(
              controller: _serialController,
              decoration: const InputDecoration(
                labelText: 'Device Serial Number',
                border: OutlineInputBorder(),
                hintText: 'e.g. KS-IOT-12345',
              ),
            ),
            const SizedBox(height: 24),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                child: const Text('Link Device'),
              ),
          ],
        ),
      ),
    );
  }
}
