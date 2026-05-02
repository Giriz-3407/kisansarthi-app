import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisansarthi/features/weather/presentation/weather_notifier.dart';

class WeatherWidget extends ConsumerWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Hardcoded location for demo or use geolocator in real app
    final weatherAsync = ref.watch(weatherProvider((lat: 18.5204, lon: 73.8567)));

    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: weatherAsync.when(
          data: (data) => Row(
            children: [
              const Icon(Icons.wb_sunny, size: 40, color: Colors.orange),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Weather in ${data['name'] ?? "Your Area"}', 
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('${data['temperature'] ?? "--"}°C | ${data['description'] ?? "Clear"}'),
                ],
              ),
              const Spacer(),
              Text('Humidity: ${data['humidity'] ?? "--"}%', 
                style: const TextStyle(fontSize: 12)),
            ],
          ),
          loading: () => const Center(child: LinearProgressIndicator()),
          error: (_, __) => const Text('Could not load weather'),
        ),
      ),
    );
  }
}
