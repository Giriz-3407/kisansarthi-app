import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisansarthi/features/farms/presentation/farms_notifier.dart';
import 'package:kisansarthi/features/lands/data/land_repository_impl.dart';
import 'package:kisansarthi/features/lands/domain/land_repository.dart';
import 'package:kisansarthi/shared/models/farm.dart';
import 'package:kisansarthi/shared/models/land.dart';
import 'package:kisansarthi/core/network/dio_client.dart';

final landRepositoryProvider = Provider<LandRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return LandRepositoryImpl(dio);
});

final farmDetailProvider = FutureProvider.family<Farm, int>((ref, farmId) async {
  final repository = ref.watch(farmRepositoryProvider);
  return repository.getFarmById(farmId);
});

final farmLandsProvider = FutureProvider.family<List<Land>, int>((ref, farmId) async {
  final repository = ref.watch(landRepositoryProvider);
  return repository.getLandsByFarm(farmId);
});
