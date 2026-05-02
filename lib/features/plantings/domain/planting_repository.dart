import 'package:kisansarthi/shared/models/planting.dart';

abstract class PlantingRepository {
  Future<Planting> createPlanting(int landId, String cropName, {String? plantingDate});
  Future<Planting> getPlantingById(int id);
  Future<void> updatePlanting(int id, {String? status, String? harvestDate});
}
