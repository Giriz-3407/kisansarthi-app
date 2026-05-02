import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisansarthi/core/network/image_url.dart';
import 'package:kisansarthi/features/diagnostics/presentation/diagnostics_notifier.dart';

class DiagnosticResultScreen extends ConsumerWidget {
  final int logId;
  const DiagnosticResultScreen({super.key, required this.logId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(diagnosisPollingProvider(logId));

    return Scaffold(
      appBar: AppBar(title: const Text('Diagnosis Result')),
      body: resultAsync.when(
        data: (result) {
          if (result['status'] == 'failed') {
            return Center(child: Text('Diagnosis failed: ${result['error_message'] ?? result['error'] ?? "Please try again"}'));
          }

          final disease = result['disease_name'] ?? 'Diagnosis pending';
          final confidence = result['confidence'] ?? 0.0;
          final remedies = result['remedies'] is List ? (result['remedies'] as List<dynamic>) : const <dynamic>[];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (result['image_path'] != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(fixImageUrl(result['image_path']?.toString())!, height: 200, width: double.infinity, fit: BoxFit.cover),
                  ),
                const SizedBox(height: 16),
                Text(disease, style: Theme.of(context).textTheme.headlineMedium),
                Text('Confidence: ${(confidence * 100).toStringAsFixed(1)}%', style: TextStyle(color: Colors.grey[600])),
                const Divider(height: 32),
                Text('Symptoms', style: Theme.of(context).textTheme.titleLarge),
                Text(result['symptoms'] ?? 'No symptoms listed.'),
                const SizedBox(height: 24),
                Text('Remedies', style: Theme.of(context).textTheme.titleLarge),
                if (remedies.isEmpty)
                  const Text('No specific remedies found.')
                else
                  ...remedies.map((r) => ListTile(
                        leading: const Icon(Icons.check_circle, color: Colors.green),
                        title: Text(r.toString()),
                      )),
                const SizedBox(height: 24),
                Text('Prevention', style: Theme.of(context).textTheme.titleLarge),
                Text(result['prevention'] ?? 'No prevention tips listed.'),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Analyzing your plant image...'),
              Text('This may take a moment.', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
