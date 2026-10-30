import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisansarthi/core/network/connection_notifier.dart';

class ServerConfigDialog extends ConsumerStatefulWidget {
  const ServerConfigDialog({super.key});

  @override
  ConsumerState<ServerConfigDialog> createState() => _ServerConfigDialogState();
}

class _ServerConfigDialogState extends ConsumerState<ServerConfigDialog> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final currentIp = ref.read(connectionNotifierProvider).currentIp;
    if (currentIp != null) {
      _controller.text = currentIp;
    }
  }

  @override
  Widget build(BuildContext context) {
    final connectionState = ref.watch(connectionNotifierProvider);
    final isConnecting = connectionState.status == ConnectionStatus.connecting;

    return AlertDialog(
      title: const Text('Connect to Server'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Enter Server IP Address:'),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: '127.0.0.1, 10.0.2.2, or LAN IP',
              border: OutlineInputBorder(),
              prefixText: 'http://',
              suffixText: ':5000',
            ),
            keyboardType: TextInputType.text,
            enabled: !isConnecting,
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              ActionChip(
                avatar: const Icon(Icons.computer, size: 16),
                label: const Text('Localhost'),
                onPressed: isConnecting ? null : () => _controller.text = '127.0.0.1',
              ),
              ActionChip(
                avatar: const Icon(Icons.phone_android, size: 16),
                label: const Text('Emulator'),
                onPressed: isConnecting ? null : () => _controller.text = '10.0.2.2',
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            '• Same PC or USB (adb reverse): 127.0.0.1\n• Android Emulator: 10.0.2.2\n• Phone on Wi-Fi: PC IP (192.168.x.x)',
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
          if (connectionState.message != null) ...[
            const SizedBox(height: 12),
            Text(
              connectionState.message!,
              style: TextStyle(
                color: connectionState.status == ConnectionStatus.connected 
                    ? Colors.green 
                    : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: isConnecting ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: isConnecting 
              ? null 
              : () => ref.read(connectionNotifierProvider.notifier).connect(_controller.text.trim()),
          child: isConnecting 
              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('Connect'),
        ),
      ],
    );
  }
}

void showServerConfigDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const ServerConfigDialog(),
  );
}
