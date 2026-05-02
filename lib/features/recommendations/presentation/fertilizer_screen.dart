import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisansarthi/core/utils/ml_input_mapper.dart';
import 'package:kisansarthi/features/crops/presentation/selected_crop_provider.dart';
import 'package:kisansarthi/features/lands/presentation/land_detail_notifier.dart';
import 'package:kisansarthi/features/recommendations/presentation/recommendations_notifier.dart';
import 'package:kisansarthi/features/soil/domain/soil_data_guard.dart';
import 'package:kisansarthi/shared/models/recommendations.dart';
import 'package:url_launcher/url_launcher.dart';

class FertilizerScreen extends ConsumerStatefulWidget {
  final int landId;
  const FertilizerScreen({super.key, required this.landId});

  @override
  ConsumerState<FertilizerScreen> createState() => _FertilizerScreenState();
}

class _FertilizerScreenState extends ConsumerState<FertilizerScreen> {
  String? _selectedSoilColor;
  bool _isLoading = false;
  List<FertilizerRecommendation>? _recommendations;
  String? _error;

  static const _soilColors = ['Red', 'Black', 'Sandy', 'Clay', 'Loamy'];

  Future<void> _fetchRecommendations() async {
    final soilReadings =
        await ref.read(landSoilReadingsProvider(widget.landId).future);
    if (!mounted) return;

    final soilData = latestValidSoilData(soilReadings);
    if (soilData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add soil data first')),
      );
      return;
    }

    final selectedCrop = await readLandScopedCrop(ref, widget.landId);
    if (!mounted) return;

    if (selectedCrop == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a crop first')),
      );
      return;
    }

    if (_selectedSoilColor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a soil color first')),
      );
      return;
    }

    final mappedCrop = MlInputMapper.normalizeFertilizerCrop(selectedCrop.name);
    final encodedSoil = MlInputMapper.encodeSoilColor(_selectedSoilColor);
    if (mappedCrop == null || encodedSoil == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid crop or soil data')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
      _recommendations = null;
    });

    try {
      final repo = ref.read(recommendationRepositoryProvider);
      dev.log("Mapped crop: $mappedCrop", name: 'FertilizerScreen');
      dev.log("Encoded soil: $encodedSoil", name: 'FertilizerScreen');
      final results = await repo.getFertilizerRecommendations(
        widget.landId,
        soilColor: encodedSoil,
        cropName: mappedCrop,
      );
      
      if (mounted) {
        setState(() {
          _recommendations = results;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedCrop = ref.watch(landCropProvider(widget.landId));
    final soilAsync = ref.watch(landSoilReadingsProvider(widget.landId));

    return Scaffold(
      appBar: AppBar(title: const Text('Fertilizer Help')),
      body: soilAsync.when(
        data: (readings) {
          final hasSoilData = latestValidSoilData(readings) != null;
          final hasCrop = selectedCrop != null;
          final canRequest = hasSoilData && hasCrop && !_isLoading;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (selectedCrop != null) ...[
                  Text(
                    'Selected crop (for this land): ${selectedCrop.name}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                ],
                if (!hasSoilData || !hasCrop) ...[
                  MaterialBanner(
                    content: Text(
                      !hasSoilData
                          ? 'Please add soil data first'
                          : 'Please select a crop first',
                    ),
                    leading: const Icon(Icons.info_outline),
                    actions: const [SizedBox.shrink()],
                  ),
                  const SizedBox(height: 16),
                ],
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Soil Color *',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedSoilColor,
                  items: _soilColors.map((color) {
                    return DropdownMenuItem(value: color, child: Text(color));
                  }).toList(),
                  onChanged: (val) {
                    setState(() => _selectedSoilColor = val);
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: canRequest ? _fetchRecommendations : null,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Get Recommendations'),
                ),
                const SizedBox(height: 24),
                if (_error != null)
                  Text(
                    'Error: $_error',
                    style: const TextStyle(color: Colors.red),
                  ),
                if (_recommendations != null && _recommendations!.isEmpty)
                  const Text('No fertilizer recommendations found.'),
                if (_recommendations != null && _recommendations!.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: _recommendations!.length,
                      itemBuilder: (context, index) {
                        final rec = _recommendations![index];
                        final isLink = rec.buyAt != null &&
                            (rec.buyAt!.startsWith('http://') ||
                                rec.buyAt!.startsWith('https://'));

                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  rec.fertilizerName,
                                  style:
                                      Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.scale,
                                      size: 20,
                                      color: Colors.blue,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Dosage: ${rec.dosage}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                if (rec.explanation != null)
                                  Text(rec.explanation!),
                                if (rec.advisory != null) ...[
                                  const SizedBox(height: 12),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.orange[50],
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.orange[200]!,
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.warning_amber,
                                          size: 20,
                                          color: Colors.orange,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            rec.advisory!,
                                            style:
                                                const TextStyle(fontSize: 13),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                if (rec.buyAt != null && rec.buyAt!.isNotEmpty) ...[
                                  const SizedBox(height: 16),
                                  isLink
                                      ? InkWell(
                                          onTap: () => _launchUrl(rec.buyAt!),
                                          child: Text(
                                            'Available at: ${rec.buyAt}',
                                            style: const TextStyle(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          'Available at: ${rec.buyAt}',
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
