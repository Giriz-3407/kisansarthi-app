import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kisansarthi/core/network/image_url.dart';
import 'package:kisansarthi/features/diagnostics/presentation/diagnostics_notifier.dart';
import 'package:intl/intl.dart';

final diagnosisHistoryProvider = FutureProvider((ref) async {
  final repository = ref.watch(diagnosticRepositoryProvider);
  return repository.getDiagnosticLogs();
});

class DiagnosisHistoryScreen extends ConsumerWidget {
  const DiagnosisHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(diagnosisHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Diagnosis History')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(diagnosisHistoryProvider.future),
        child: historyAsync.when(
          data: (logs) => logs.isEmpty
              ? const Center(child: Text('No history found.'))
              : ListView.builder(
                  itemCount: logs.length,
                  itemBuilder: (context, index) {
                    final log = logs[index];
                    final date = log['created_at'] != null 
                        ? DateFormat.yMMMd().format(DateTime.parse(log['created_at']))
                        : 'Date unavailable';
                    
                    return ListTile(
                      leading: log['image_path'] != null
                          ? CircleAvatar(backgroundImage: NetworkImage(fixImageUrl(log['image_path']?.toString())!))
                          : const CircleAvatar(child: Icon(Icons.bug_report)),
                      title: Text(log['disease_name'] ?? 'Processing...'),
                      subtitle: Text('Date: $date'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/diagnostics/result/${log['id']}'),
                    );
                  },
                ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}
