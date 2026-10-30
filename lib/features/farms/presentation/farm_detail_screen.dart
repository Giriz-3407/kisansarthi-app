import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kisansarthi/core/network/image_url.dart';
import 'package:kisansarthi/features/farms/presentation/farm_detail_notifier.dart';
import 'package:kisansarthi/features/farms/presentation/farms_notifier.dart';
import 'package:kisansarthi/features/farms/presentation/widgets/live_sensor_card.dart';

class FarmDetailScreen extends ConsumerWidget {
  final int farmId;
  const FarmDetailScreen({super.key, required this.farmId});

  void _confirmDelete(BuildContext context, WidgetRef ref, String farmName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: Text("Are you sure you want to delete '$farmName'? This will also delete all associated lands."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await ref.read(farmsNotifierProvider.notifier).deleteFarm(farmId);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Farm deleted successfully'), backgroundColor: Colors.green),
                  );
                  context.pop(); // Go back to dashboard
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
    final farmAsync = ref.watch(farmDetailProvider(farmId));
    final landsAsync = ref.watch(farmLandsProvider(farmId));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: farmAsync.when(
          data: (farm) => Text(farm.name, style: const TextStyle(color: Colors.white)),
          loading: () => const Text('Loading...', style: TextStyle(color: Colors.white)),
          error: (_, __) => const Text('Error', style: TextStyle(color: Colors.white)),
        ),
        actions: farmAsync.when(
          data: (farm) => [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: () => context.push('/farms/edit', extra: farm),
              tooltip: 'Edit Farm',
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.white),
              onPressed: () => _confirmDelete(context, ref, farm.name),
              tooltip: 'Delete Farm',
            ),
          ],
          loading: () => [],
          error: (_, __) => [],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(farmDetailProvider(farmId));
          ref.invalidate(farmLandsProvider(farmId));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              farmAsync.when(
                data: (farm) => Column(
                  children: [
                    if (farm.imagePath != null)
                      Image.network(fixImageUrl(farm.imagePath)!, height: 200, width: double.infinity, fit: BoxFit.cover),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Location: ${farm.location ?? "N/A"}', style: Theme.of(context).textTheme.bodyLarge),
                          Text('Address: ${farm.address ?? "N/A"}'),
                        ],
                      ),
                    ),
                  ],
                ),
                loading: () => const LinearProgressIndicator(),
                error: (err, _) => Center(child: Text('Error: $err')),
              ),

              // Live IoT Sensor Telemetry Card
              LiveSensorCard(farmId: farmId),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Lands', style: Theme.of(context).textTheme.headlineSmall),
                    ElevatedButton.icon(
                      onPressed: () => context.push('/farms/$farmId/lands/add'),
                      icon: const Icon(Icons.add),
                      label: const Text('Add Land'),
                    ),
                  ],
                ),
              ),
              landsAsync.when(
                data: (lands) => lands.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('No lands added yet.'),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: lands.length,
                        itemBuilder: (context, index) {
                          final land = lands[index];
                          return ListTile(
                            title: Text(land.name),
                            subtitle: Text('${land.area ?? 0} ${land.areaUnit ?? ""}'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => context.push('/lands/${land.id}'),
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
}
