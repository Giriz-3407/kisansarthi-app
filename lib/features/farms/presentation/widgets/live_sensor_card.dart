import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kisansarthi/features/farms/presentation/live_sensor_notifier.dart';

class LiveSensorCard extends ConsumerWidget {
  final int farmId;

  const LiveSensorCard({super.key, required this.farmId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sensorState = ref.watch(liveSensorProvider(farmId));
    final notifier = ref.read(liveSensorProvider(farmId).notifier);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.sensors, color: Colors.green, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Live Field Telemetry (IoT)',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        sensorState.telemetry != null
                            ? 'Device: ${sensorState.telemetry!['device_name'] ?? 'ESP32 Node'}'
                            : 'On-demand multi-second averaged readings',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                if (sensorState.isSampling)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange.shade300),
                    ),
                    child: Text(
                      '${sensorState.countdownSeconds}s',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade800,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // State Content
            if (sensorState.isSampling) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Sampling sensor stream over ${sensorState.countdownSeconds}s...',
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Gathering consecutive telemetry packets to compute stable averages and filter out noise.',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 8),
                    const LinearProgressIndicator(),
                  ],
                ),
              ),
            ] else if (sensorState.errorMessage != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 22),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sensor Telemetry Notice',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 13),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            sensorState.errorMessage!,
                            style: TextStyle(color: Colors.red.shade900, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ] else if (sensorState.telemetry != null) ...[
              // Telemetry Metrics Grid
              Row(
                children: [
                  // Temperature Card
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.thermostat, color: Colors.deepOrange, size: 18),
                              const SizedBox(width: 4),
                              Text('Soil Temp', style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${sensorState.telemetry!['temperature']} °C',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            sensorState.telemetry!['temperature_stability']?.toString() ?? 'Stable',
                            style: TextStyle(fontSize: 10, color: Colors.green.shade800, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Moisture Card
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.water_drop, color: Colors.blue, size: 18),
                              const SizedBox(width: 4),
                              Text('Soil Moisture', style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${sensorState.telemetry!['humidity']} %',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            sensorState.telemetry!['moisture_stability']?.toString() ?? 'Stable',
                            style: TextStyle(fontSize: 10, color: Colors.green.shade800, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Metadata Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Averaged across ${sensorState.telemetry!['samples_collected']} samples',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                  if (sensorState.lastFetchedAt != null)
                    Text(
                      DateFormat.jm().format(sensorState.lastFetchedAt!),
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                ],
              ),
            ] else ...[
              // Placeholder State
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'No live readings sampled yet. Tap below to gather real-time telemetry from your field sensor node.',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ),
            ],

            const SizedBox(height: 12),

            // Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: sensorState.isSampling ? null : () => notifier.fetchLiveTelemetry(),
                icon: sensorState.isSampling
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.refresh),
                label: Text(
                  sensorState.isSampling
                      ? 'Sampling Sensor Stream...'
                      : (sensorState.telemetry != null ? 'Refresh Live Readings' : 'Fetch Live Sensor Data'),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
