import 'package:dio/dio.dart';
import 'package:kisansarthi/core/network/api_utils.dart';
import 'package:kisansarthi/features/plantings/domain/planting_repository.dart';
import 'package:kisansarthi/shared/models/planting.dart';

class PlantingRepositoryImpl implements PlantingRepository {
  final Dio _dio;

  PlantingRepositoryImpl(this._dio);

  Map<String, dynamic> _toPlantingJson(Map<String, dynamic> raw) {
    return {
      ...raw,
      'harvest_date': raw['actual_harvest_date'] ?? raw['expected_harvest_date'],
    };
  }

  Future<int> _resolveCropId(String cropNameOrId) async {
    final parsed = int.tryParse(cropNameOrId.trim());
    if (parsed != null) return parsed;

    final response = await _dio.get('/crops');
    final crops = ApiUtils.extractList(response.data);
    for (final crop in crops) {
      if (crop is Map<String, dynamic>) {
        final name = crop['crop_name']?.toString().toLowerCase();
        if (name == cropNameOrId.trim().toLowerCase()) {
          return (crop['id'] as num).toInt();
        }
      }
    }
    throw DioException(
      requestOptions: RequestOptions(path: '/lands/*/plantings'),
      error: 'Unable to map crop "$cropNameOrId" to a valid crop_id.',
      type: DioExceptionType.badResponse,
    );
  }

  @override
  Future<Planting> createPlanting(int landId, String cropName, {String? plantingDate}) async {
    final cropId = await _resolveCropId(cropName);
    final response = await _dio.post('/lands/$landId/plantings', data: {
      'crop_id': cropId,
      if (plantingDate != null) 'planting_date': plantingDate,
    });
    final map = ApiUtils.extractMap(response.data);
    return Planting.fromJson(_toPlantingJson(map));
  }

  @override
  Future<Planting> getPlantingById(int id) async {
    final response = await _dio.get('/plantings/$id');
    final map = ApiUtils.extractMap(response.data);
    return Planting.fromJson(_toPlantingJson(map));
  }

  @override
  Future<void> updatePlanting(int id, {String? status, String? harvestDate}) async {
    await _dio.put('/plantings/$id', data: {
      if (status != null) 'status': status,
      if (harvestDate != null) 'actual_harvest_date': harvestDate,
    });
  }
}
