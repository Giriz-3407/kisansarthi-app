import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisansarthi/features/lands/presentation/land_detail_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectedCrop {
  const SelectedCrop({
    required this.name,
    this.id,
  });

  final String name;
  final int? id;
}

final landCropProvider =
    StateNotifierProvider.family<SelectedCropNotifier, SelectedCrop?, int>((ref, landId) {
  return SelectedCropNotifier(landId)..load();
});

Future<SelectedCrop?> readLandScopedCrop(WidgetRef ref, int landId) async {
  final selectedCrop = ref.read(landCropProvider(landId));
  if (selectedCrop != null) return selectedCrop;

  final land = await ref.read(landDetailProvider(landId).future);
  final planting = land.currentPlanting;
  if (planting == null || planting.cropName.trim().isEmpty) return null;

  await ref.read(landCropProvider(landId).notifier).selectCrop(
        name: planting.cropName,
      );
  return SelectedCrop(name: planting.cropName);
}

class SelectedCropNotifier extends StateNotifier<SelectedCrop?> {
  SelectedCropNotifier(this.landId) : super(null);

  final int landId;

  String get _nameKey => 'selected_crop_name_$landId';
  String get _idKey => 'selected_crop_id_$landId';

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final cropName = prefs.getString(_nameKey);
    if (cropName == null || cropName.trim().isEmpty) return;

    state = SelectedCrop(
      name: cropName,
      id: prefs.getInt(_idKey),
    );
  }

  Future<void> selectCrop({
    required String name,
    int? id,
  }) async {
    final normalizedName = name.trim();
    if (normalizedName.isEmpty || normalizedName.toLowerCase() == 'unknown') {
      throw ArgumentError('A valid crop must be selected.');
    }

    state = SelectedCrop(name: normalizedName, id: id);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, normalizedName);
    if (id == null) {
      await prefs.remove(_idKey);
    } else {
      await prefs.setInt(_idKey, id);
    }
  }

  Future<void> clear() async {
    state = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_nameKey);
    await prefs.remove(_idKey);
  }
}
