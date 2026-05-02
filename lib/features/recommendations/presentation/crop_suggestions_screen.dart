import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kisansarthi/features/crops/presentation/selected_crop_provider.dart';
import 'package:kisansarthi/features/lands/presentation/land_detail_notifier.dart';
import 'package:kisansarthi/features/recommendations/presentation/recommendations_notifier.dart';
import 'package:kisansarthi/features/soil/domain/soil_data_guard.dart';

class CropSuggestionsScreen extends ConsumerStatefulWidget {
  final int landId;
  const CropSuggestionsScreen({super.key, required this.landId});

  @override
  ConsumerState<CropSuggestionsScreen> createState() => _CropSuggestionsScreenState();
}

class _CropSuggestionsScreenState extends ConsumerState<CropSuggestionsScreen> {
  bool _isLoading = false;

  Future<void> _refreshCropSuggestions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      ref.invalidate(landSoilReadingsProvider(widget.landId));
      await ref.refresh(cropSuggestionsProvider(widget.landId).future);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Suggestions updated ✅")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to refresh suggestions ❌"), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final soilAsync = ref.watch(landSoilReadingsProvider(widget.landId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Suggestions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _refreshCropSuggestions,
            tooltip: 'Refresh Suggestions',
          ),
        ],
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : soilAsync.when(
            data: (readings) {
              final soilData = latestValidSoilData(readings);
              if (soilData == null) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.info_outline, size: 48, color: Colors.orange),
                        const SizedBox(height: 16),
                        const Text('Please add soil data first'),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () => context.push('/lands/${widget.landId}/manual-soil'),
                          icon: const Icon(Icons.add_chart),
                          label: const Text('Add Soil Data'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final suggestionsAsync = ref.watch(cropSuggestionsProvider(widget.landId));
              return suggestionsAsync.when(
                data: (suggestions) {
                  // ignore: avoid_print
                  print('DEBUG: recommendations = $suggestions');

                  if (suggestions.isEmpty) {
                    return const Center(child: Text('No suggestions found for this land.'));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: suggestions.length,
                    itemBuilder: (context, index) {
                      // FIX: Use suggestions[index] directly to ensure each card has its own data
                      final crop = suggestions[index];
                      final cropName = crop.cropName;
                      final match = crop.match;
                      final isRecommended = index == 0;
                  
                      return Card(
                        color: isRecommended ? Colors.green[50] : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: isRecommended ? Colors.green.shade300 : Colors.transparent,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cropName,
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      if (isRecommended)
                                        Chip(
                                          label: const Text('Recommended', style: TextStyle(fontSize: 12)),
                                          backgroundColor: Colors.green[100],
                                          visualDensity: VisualDensity.compact,
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
                                      Chip(
                                        label: Text('${(match * 100).toStringAsFixed(1)}% Confidence', style: const TextStyle(fontSize: 12)),
                                        backgroundColor: _getMatchColor(match),
                                        visualDensity: VisualDensity.compact,
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              if ((crop.reason ?? '').isNotEmpty)
                                Text(crop.reason!, style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.black87)),
                              if ((crop.explanation ?? '').isNotEmpty) ...[
                                const Divider(height: 24),
                                Text(crop.explanation!, style: const TextStyle(fontSize: 14)),
                              ],
                              if (crop.expectedYield != null) ...[
                                const SizedBox(height: 8),
                                Text('Expected Yield: ${crop.expectedYield}',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              ],
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: cropName.trim().isEmpty
                                    ? null
                                    : () async {
                                        await ref.read(landCropProvider(widget.landId).notifier).selectCrop(
                                              name: cropName,
                                            );
                                        if (!context.mounted) return;
                                        context.push('/lands/${widget.landId}/selected-crop');
                                      },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 40),
                                  backgroundColor: Colors.green[700],
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Select This Crop'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(child: Text('Error: $err')),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('Error: $err')),
          ),
    );
  }

  Color _getMatchColor(double match) {
    if (match >= 0.8) return Colors.green[100]!;
    if (match >= 0.6) return Colors.yellow[100]!;
    return Colors.orange[100]!;
  }
}
