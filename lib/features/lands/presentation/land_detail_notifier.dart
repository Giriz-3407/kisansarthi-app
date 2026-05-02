import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisansarthi/features/lands/presentation/add_land_screen.dart';
import 'package:kisansarthi/features/farms/presentation/farm_detail_notifier.dart';
import 'package:kisansarthi/features/soil/data/soil_repository_impl.dart';
import 'package:kisansarthi/features/soil/domain/soil_repository.dart';
import 'package:kisansarthi/shared/models/land.dart';
import 'package:kisansarthi/shared/models/soil_reading.dart';
import 'package:kisansarthi/core/network/dio_client.dart';

final soilRepositoryProvider = Provider<SoilRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return SoilRepositoryImpl(dio);
});

final landDetailProvider = FutureProvider.family<Land, int>((ref, landId) async {
  final repository = ref.watch(landRepositoryProvider);
  return repository.getLandById(landId);
});

final landSoilReadingsProvider = FutureProvider.family<List<SoilReading>, int>((ref, landId) async {
  final repository = ref.watch(soilRepositoryProvider);
  return repository.getSoilReadings(landId, limit: 10);
});
