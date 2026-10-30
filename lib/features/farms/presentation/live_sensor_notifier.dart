import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisansarthi/features/farms/presentation/farms_notifier.dart';

class LiveSensorState {
  final bool isSampling;
  final int countdownSeconds;
  final Map<String, dynamic>? telemetry;
  final String? errorMessage;
  final DateTime? lastFetchedAt;

  const LiveSensorState({
    this.isSampling = false,
    this.countdownSeconds = 0,
    this.telemetry,
    this.errorMessage,
    this.lastFetchedAt,
  });

  LiveSensorState copyWith({
    bool? isSampling,
    int? countdownSeconds,
    Map<String, dynamic>? telemetry,
    String? errorMessage,
    bool clearError = false,
    DateTime? lastFetchedAt,
  }) {
    return LiveSensorState(
      isSampling: isSampling ?? this.isSampling,
      countdownSeconds: countdownSeconds ?? this.countdownSeconds,
      telemetry: telemetry ?? this.telemetry,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      lastFetchedAt: lastFetchedAt ?? this.lastFetchedAt,
    );
  }
}

class LiveSensorNotifier extends FamilyNotifier<LiveSensorState, int> {
  Timer? _timer;

  @override
  LiveSensorState build(int arg) {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return const LiveSensorState();
  }

  Future<void> fetchLiveTelemetry({int sampleWindowSeconds = 4}) async {
    final farmId = arg;
    _timer?.cancel();

    // Start sampling phase with countdown
    state = state.copyWith(
      isSampling: true,
      countdownSeconds: sampleWindowSeconds,
      clearError: true,
    );

    // Run live countdown animation (e.g. 4s, 3s, 2s, 1s...)
    int remaining = sampleWindowSeconds;
    final completer = Completer<void>();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remaining--;
      if (remaining <= 0) {
        timer.cancel();
        if (!completer.isCompleted) completer.complete();
      } else {
        state = state.copyWith(countdownSeconds: remaining);
      }
    });

    try {
      final repository = ref.read(farmRepositoryProvider);

      // Wait for countdown window to allow active sensor telemetry to accumulate
      await completer.future;

      final data = await repository.getLiveSensorData(farmId, samples: 5);
      state = state.copyWith(
        isSampling: false,
        countdownSeconds: 0,
        telemetry: data,
        clearError: true,
        lastFetchedAt: DateTime.now(),
      );
    } catch (e) {
      String cleanMessage = e.toString();
      if (cleanMessage.startsWith('Exception: ')) {
        cleanMessage = cleanMessage.substring('Exception: '.length);
      }
      state = state.copyWith(
        isSampling: false,
        countdownSeconds: 0,
        errorMessage: cleanMessage,
      );
    }
  }
}

final liveSensorProvider = NotifierProvider.family<LiveSensorNotifier, LiveSensorState, int>(
  () => LiveSensorNotifier(),
);
