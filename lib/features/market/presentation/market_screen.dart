import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisansarthi/features/crops/presentation/selected_crop_provider.dart';
import 'package:kisansarthi/features/market/data/market_repository_impl.dart';
import 'package:kisansarthi/core/network/dio_client.dart';
import 'package:kisansarthi/shared/models/market_price.dart';
import 'package:kisansarthi/shared/widgets/connection_status_dot.dart';

final marketRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return MarketRepositoryImpl(dio);
});

class MarketScreen extends ConsumerStatefulWidget {
  const MarketScreen({super.key, this.landId});

  final int? landId;

  @override
  ConsumerState<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends ConsumerState<MarketScreen> {
  final _cropController = TextEditingController();
  final _locationController = TextEditingController();
  List<MarketPrice>? _prices;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final landId = widget.landId;
      if (landId == null) return;
      final selectedCrop = await readLandScopedCrop(ref, landId);
      if (selectedCrop != null && _cropController.text.trim().isEmpty) {
        _cropController.text = selectedCrop.name;
      }
    });
  }

  @override
  void dispose() {
    _cropController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    final crop = _cropController.text.trim();
    if (crop.isEmpty || crop.toLowerCase() == 'unknown') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a crop first')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final repo = ref.read(marketRepositoryProvider);
      final results = await repo.getMarketPrices(
        crop: crop,
        location: _locationController.text.isEmpty ? null : _locationController.text,
      );
      setState(() => _prices = results);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Search failed: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedCrop = widget.landId == null
        ? null
        : ref.watch(landCropProvider(widget.landId!));
    if (selectedCrop != null && _cropController.text.trim().isEmpty) {
      _cropController.text = selectedCrop.name;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Prices'),
        actions: const [ConnectionStatusDot()],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cropController,
                    decoration: const InputDecoration(labelText: 'Crop', hintText: 'e.g. Rice'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _locationController,
                    decoration: const InputDecoration(labelText: 'Location', hintText: 'e.g. Mumbai'),
                  ),
                ),
                IconButton(
                  onPressed: _search,
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_prices == null)
            const Expanded(child: Center(child: Text('Search for crop prices')))
          else if (_prices!.isEmpty)
            const Expanded(child: Center(child: Text('No prices found')))
          else
            Expanded(
              child: ListView.builder(
                itemCount: _prices!.length,
                itemBuilder: (context, index) {
                  final item = _prices![index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.commodity,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                '₹${item.modalPrice}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text('${item.market}, ${item.district}, ${item.state}'),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Min: ₹${item.minPrice}'),
                              Text('Max: ₹${item.maxPrice}'),
                              Text('Variety: ${item.variety}'),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text('Arrival Date: ${item.arrivalDate}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
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
  }
}
