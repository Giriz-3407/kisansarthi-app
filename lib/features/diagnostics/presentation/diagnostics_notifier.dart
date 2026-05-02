import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisansarthi/core/config/env_config.dart';
import 'package:kisansarthi/core/network/dio_client.dart';
import 'package:kisansarthi/features/diagnostics/data/diagnostic_repository_impl.dart';
import 'package:kisansarthi/features/diagnostics/domain/diagnostic_repository.dart';

final diagnosticRepositoryProvider = Provider<DiagnosticRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return DiagnosticRepositoryImpl(dio);
});

final diagnosisPollingProvider = StateNotifierProvider.family<DiagnosisPollingNotifier, AsyncValue<Map<String, dynamic>>, int>((ref, logId) {
  final repository = ref.watch(diagnosticRepositoryProvider);
  return DiagnosisPollingNotifier(repository, logId);
});

class DiagnosisPollingNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  final DiagnosticRepository _repository;
  final int _logId;
  Timer? _timer;

  DiagnosisPollingNotifier(this._repository, this._logId) : super(const AsyncValue.loading()) {
    if (EnvConfig.useMock) {
      _fetchInstantMock();
    } else {
      _startPolling();
    }
  }

  Future<void> _fetchInstantMock() async {
    try {
      // Small delay to simulate network feel without polling
      await Future.delayed(const Duration(milliseconds: 500));
      final result = await _repository.getDiagnosticLog(_logId);
      state = AsyncValue.data(result);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      try {
        final result = await _repository.getDiagnosticLog(_logId);
        if (result['status'] == 'completed' || result['status'] == 'failed') {
          state = AsyncValue.data(result);
          timer.cancel();
        }
      } catch (e, st) {
        state = AsyncValue.error(e, st);
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
