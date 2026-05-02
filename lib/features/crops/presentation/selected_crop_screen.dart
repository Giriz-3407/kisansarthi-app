import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kisansarthi/features/crops/presentation/selected_crop_provider.dart';
import 'package:kisansarthi/features/lands/presentation/land_detail_notifier.dart';
import 'package:kisansarthi/features/soil/domain/soil_data_guard.dart';

class SelectedCropScreen extends ConsumerWidget {
  const SelectedCropScreen({super.key, required this.landId});

  final int landId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCrop = ref.watch(landCropProvider(landId));
    final landAsync = ref.watch(landDetailProvider(landId));
    final soilAsync = ref.watch(landSoilReadingsProvider(landId));

    void showSoilMessage() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add soil data first')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Selected Crop')),
      body: soilAsync.when(
        data: (readings) {
          final soilData = latestValidSoilData(readings);
          final hasSoilData = soilData != null;
          final cropName =
              selectedCrop?.name ?? landAsync.value?.currentPlanting?.cropName;

          if (cropName == null || cropName.trim().isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.eco_outlined, size: 56, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text('No crop selected yet.'),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: hasSoilData
                          ? () => context.push('/lands/$landId/crop-suggestions')
                          : showSoilMessage,
                      icon: const Icon(Icons.tips_and_updates),
                      label: const Text('Select Crop'),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Selected crop (for this land): $cropName',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Chip(
                  avatar: const Icon(Icons.check_circle, size: 18),
                  label: const Text('Active Crop'),
                  backgroundColor: Colors.green.shade100,
                ),
              ),
              if (!hasSoilData) ...[
                const SizedBox(height: 16),
                MaterialBanner(
                  content: const Text('Please add soil data first'),
                  leading: const Icon(Icons.info_outline),
                  actions: [
                    TextButton(
                      onPressed: () => context.push('/lands/$landId/manual-soil'),
                      child: const Text('Add Soil Data'),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: hasSoilData
                    ? () => context.push('/lands/$landId/fertilizer')
                    : null,
                icon: const Icon(Icons.science),
                label: const Text('Fertilizer Recommendation'),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () => context.go('/market?landId=$landId'),
                icon: const Icon(Icons.store),
                label: const Text('Market Prices'),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () => context.go('/scan?landId=$landId'),
                icon: const Icon(Icons.camera_alt),
                label: const Text('Disease Detection'),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
