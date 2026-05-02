import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisansarthi/features/lands/presentation/land_detail_notifier.dart';
import 'package:kisansarthi/shared/models/soil_reading.dart';

class SoilMonitoringScreen extends ConsumerWidget {
  final int landId;
  const SoilMonitoringScreen({super.key, required this.landId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final soilAsync = ref.watch(landSoilReadingsProvider(landId));

    return Scaffold(
      appBar: AppBar(title: const Text('Soil Trends')),
      body: soilAsync.when(
        data: (readings) => readings.isEmpty
            ? const Center(child: Text('No data available for charts.'))
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildChartCard(context, 'NPK Levels', readings, (r) => [r.nitrogen ?? 0, r.phosphorus ?? 0, r.potassium ?? 0]),
                    const SizedBox(height: 16),
                    _buildChartCard(context, 'pH Level', readings, (r) => [r.ph ?? 0]),
                    const SizedBox(height: 16),
                    _buildChartCard(context, 'Rainfall (mm)', readings, (r) => [r.rainfall ?? 0]),
                  ],
                ),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildChartCard(BuildContext context, String title, List<SoilReading> readings, List<double> Function(SoilReading) valueSelector) {
    // Take last 7 readings and reverse to get chronological order
    final displayReadings = readings.take(7).toList().reversed.toList();
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey[300]!)),
                  lineBarsData: _generateLineBars(displayReadings, valueSelector),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<LineChartBarData> _generateLineBars(List<SoilReading> readings, List<double> Function(SoilReading) valueSelector) {
    if (readings.isEmpty) return [];

    final List<List<FlSpot>> spotsList = [];
    final int numLines = valueSelector(readings.first).length;

    for (int i = 0; i < numLines; i++) {
      spotsList.add([]);
    }

    for (int index = 0; index < readings.length; index++) {
      final values = valueSelector(readings[index]);
      for (int i = 0; i < numLines; i++) {
        spotsList[i].add(FlSpot(index.toDouble(), values[i]));
      }
    }

    final List<Color> colors = [Colors.green, Colors.blue, Colors.orange];

    return spotsList.asMap().entries.map((entry) {
      return LineChartBarData(
        spots: entry.value,
        isCurved: true,
        color: colors[entry.key % colors.length],
        barWidth: 3,
        dotData: const FlDotData(show: true),
      );
    }).toList();
  }
}
