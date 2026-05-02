import 'package:dio/dio.dart';
import 'package:kisansarthi/core/network/api_utils.dart';
import 'package:kisansarthi/features/soil/domain/soil_repository.dart';
import 'package:kisansarthi/shared/models/soil_reading.dart';

class SoilRepositoryImpl implements SoilRepository {
  final Dio _dio;

  SoilRepositoryImpl(this._dio);

  Map<String, dynamic> _toSoilReadingJson(Map<String, dynamic> raw) {
    return {
      'id': raw['id'],
      'land_id': raw['land_id'],
      'device_id': raw['device_id'],
      'nitrogen': raw['N'] ?? raw['nitrogen'] ?? raw['nitrogen_value'],
      'phosphorus': raw['P'] ?? raw['phosphorus'] ?? raw['phosphorus_value'],
      'potassium': raw['K'] ?? raw['potassium'] ?? raw['potassium_value'],
      'ph': raw['ph'] ?? raw['ph_value'],
      'rainfall': raw['rainfall'] ?? raw['rainfall_value'],
      'temperature': raw['temperature'] ?? raw['temperature_value'],
      'humidity': raw['humidity'] ?? raw['humidity_value'],
      'reading_type': raw['reading_type'],
      'created_at': raw['timestamp'] ?? raw['created_at'],
    };
  }

  @override
  Future<List<SoilReading>> getSoilReadings(int landId, {int? limit, int? offset}) async {
    final response = await _dio.get('/lands/$landId/soil-readings', queryParameters: {
      if (limit != null) 'limit': limit,
      if (offset != null) 'offset': offset,
    });
    final list = ApiUtils.extractWrappedList(response.data, keys: ['readings']);
    return list
        .whereType<Map<String, dynamic>>()
        .map((e) => SoilReading.fromJson(_toSoilReadingJson(e)))
        .toList();
  }

  @override
  Future<void> addManualSoilReading(int landId, Map<String, dynamic> data) async {
    // Ensure request body matches backend requirements exactly
    final payload = {
      'N': data['N'],
      'P': data['P'],
      'K': data['K'],
      'ph': data['ph'],
      'rainfall': data['rainfall'],
      'temperature': data['temperature'],
      'humidity': data['humidity'],
    };
    await _dio.post('/lands/$landId/manual-soil-reading', data: payload);
  }
}
