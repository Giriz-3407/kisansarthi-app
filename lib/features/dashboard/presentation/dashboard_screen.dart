import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kisansarthi/core/network/image_url.dart';
import 'package:kisansarthi/features/farms/presentation/farms_notifier.dart';
import 'package:kisansarthi/features/dashboard/presentation/widgets/weather_widget.dart';
import 'package:kisansarthi/shared/widgets/connection_status_dot.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmsAsync = ref.watch(farmsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('KisanSarthi'),
        actions: const [
          ConnectionStatusDot(),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(farmsNotifierProvider.notifier).fetchFarms(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WeatherWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Farms',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextButton.icon(
                    onPressed: () => context.push('/farms/add'),
                    icon: const Icon(Icons.add),
                    label: const Text('Add'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: farmsAsync.when(
                data: (farms) => farms.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.agriculture, size: 64, color: Colors.grey),
                            const SizedBox(height: 16),
                            const Text('No farms found.'),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => context.push('/farms/add'),
                              child: const Text('Add your first farm'),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: farms.length,
                        itemBuilder: (context, index) {
                          final farm = farms[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: ListTile(
                              leading: farm.imagePath != null
                                  ? CircleAvatar(backgroundImage: NetworkImage(fixImageUrl(farm.imagePath)!))
                                  : const CircleAvatar(child: Icon(Icons.landscape)),
                              title: Text(farm.name),
                              subtitle: Text(farm.location ?? 'No location'),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () => context.push('/farms/${farm.id}'),
                            ),
                          );
                        },
                      ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
