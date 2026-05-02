import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kisansarthi/features/farms/presentation/farm_detail_notifier.dart';
import 'package:kisansarthi/features/lands/presentation/land_detail_notifier.dart';
import 'package:kisansarthi/features/soil/domain/soil_data_guard.dart';
import 'package:intl/intl.dart';

class LandDetailScreen extends ConsumerWidget {
  final int landId;
  const LandDetailScreen({super.key, required this.landId});

  void _confirmDelete(BuildContext context, WidgetRef ref, String landName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: Text("Are you sure you want to delete '$landName'? This will also delete all associated soil data and plantings."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                final land = ref.read(landDetailProvider(landId)).value;
                final repository = ref.read(landRepositoryProvider);
                await repository.deleteLand(landId);
                
                if (land != null) {
                  ref.invalidate(farmLandsProvider(land.farmId));
                }

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Field deleted successfully'), backgroundColor: Colors.green),
                  );
                  context.pop(); // Go back to farm detail
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to delete: $e'), backgroundColor: Colors.red),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final landAsync = ref.watch(landDetailProvider(landId));
    final soilAsync = ref.watch(landSoilReadingsProvider(landId));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: landAsync.when(
          data: (land) => Text(land.name, style: const TextStyle(color: Colors.white)),
          loading: () => const Text('Loading...', style: TextStyle(color: Colors.white)),
          error: (_, __) => const Text('Error', style: TextStyle(color: Colors.white)),
        ),
        actions: [
          landAsync.when(
            data: (land) => IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.white),
              onPressed: () => _confirmDelete(context, ref, land.name),
              tooltip: 'Delete Field',
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(landDetailProvider(landId));
          ref.invalidate(landSoilReadingsProvider(landId));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              landAsync.when(
                data: (land) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Type: ${land.landType ?? "N/A"}', style: Theme.of(context).textTheme.bodyLarge),
                      Text('Area: ${land.area ?? 0} ${land.areaUnit ?? ""}'),
                      if (land.currentPlanting != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            border: Border.all(color: Colors.green.shade200),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.eco, color: Colors.green),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Currently Planted: ${land.currentPlanting!.cropName}', 
                                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                                    if (land.currentPlanting!.plantingDate != null)
                                      Text('Planted on: ${land.currentPlanting!.plantingDate}',
                                        style: TextStyle(color: Colors.green.shade800)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                loading: () => const LinearProgressIndicator(),
                error: (err, _) => Center(child: Text('Error: $err')),
              ),
              const Divider(),
              _buildSectionHeader(context, 'Actions'),
              soilAsync.when(
                data: (readings) {
                  final hasSoilData = latestValidSoilData(readings) != null;

                  void showSoilMessage() {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please add soil data first')),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => context.push('/lands/$landId/manual-soil'),
                          icon: const Icon(Icons.add_chart),
                          label: const Text('Add Soil Data'),
                        ),
                        ElevatedButton.icon(
                          onPressed: hasSoilData
                              ? () => context.push('/lands/$landId/crop-suggestions')
                              : null,
                          onLongPress: hasSoilData ? null : showSoilMessage,
                          icon: const Icon(Icons.tips_and_updates),
                          label: const Text('Crop Suggestions'),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => context.push('/lands/$landId/selected-crop'),
                          icon: const Icon(Icons.eco),
                          label: const Text('Selected Crop'),
                        ),
                        ElevatedButton.icon(
                          onPressed: hasSoilData
                              ? () => context.push('/lands/$landId/fertilizer')
                              : null,
                          onLongPress: hasSoilData ? null : showSoilMessage,
                          icon: const Icon(Icons.science),
                          label: const Text('Fertilizer Help'),
                        ),
                      ],
                    ),
                  );
                },
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: LinearProgressIndicator(),
                ),
                error: (err, _) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Error: $err'),
                ),
              ),
              const Divider(),
              _buildSectionHeader(context, 'Latest Soil Readings'),
              soilAsync.when(
                data: (readings) => readings.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('No soil data yet.'),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: readings.length,
                        itemBuilder: (context, index) {
                          final reading = readings[index];
                          final date = reading.createdAt != null 
                              ? DateFormat.yMMMd().add_Hm().format(DateTime.parse(reading.createdAt!))
                              : 'Date unavailable';
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: ExpansionTile(
                              title: Text('Reading on $date'),
                              subtitle: Text('N: ${reading.nitrogen}, P: ${reading.phosphorus}, K: ${reading.potassium}'),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('pH: ${reading.ph}'),
                                      Text('Rainfall: ${reading.rainfall} mm'),
                                      Text('Temperature: ${reading.temperature}°C'),
                                      Text('Humidity: ${reading.humidity}%'),
                                      Text('Type: ${reading.readingType}'),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(child: Text('Error: $err')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}
