import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisansarthi/core/network/dio_client.dart';
import 'package:kisansarthi/features/farms/data/farm_repository_impl.dart';
import 'package:kisansarthi/features/farms/domain/farm_repository.dart';
import 'package:kisansarthi/shared/models/farm.dart';

final farmRepositoryProvider = Provider<FarmRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return FarmRepositoryImpl(dio);
});

final farmsNotifierProvider = StateNotifierProvider<FarmsNotifier, AsyncValue<List<Farm>>>((ref) {
  final repository = ref.watch(farmRepositoryProvider);
  return FarmsNotifier(repository);
});

class FarmsNotifier extends StateNotifier<AsyncValue<List<Farm>>> {
  final FarmRepository _repository;

  FarmsNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchFarms();
  }

  Future<void> fetchFarms() async {
    state = const AsyncValue.loading();
    try {
      final farms = await _repository.getFarms();
      state = AsyncValue.data(farms);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addFarm(String name, {String? location, String? address}) async {
    try {
      await _repository.createFarm(name, location: location, address: address);
      await fetchFarms();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteFarm(int id) async {
    try {
      await _repository.deleteFarm(id);
      await fetchFarms();
    } catch (e) {
      rethrow;
    }
  }
}
