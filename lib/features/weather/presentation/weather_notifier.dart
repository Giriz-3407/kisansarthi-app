import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisansarthi/core/network/dio_client.dart';
import 'package:kisansarthi/features/weather/data/weather_repository_impl.dart';
import 'package:kisansarthi/features/weather/domain/weather_repository.dart';

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return WeatherRepositoryImpl(dio);
});

final weatherProvider = FutureProvider.family<Map<String, dynamic>, ({double lat, double lon})>((ref, pos) async {
  final repository = ref.watch(weatherRepositoryProvider);
  return repository.getWeather(pos.lat, pos.lon);
});
