import 'dart:io';
import 'package:dio/dio.dart';
import 'package:kisansarthi/core/network/api_utils.dart';
import 'package:kisansarthi/core/network/image_url.dart';
import 'package:kisansarthi/features/farms/domain/farm_repository.dart';
import 'package:kisansarthi/shared/models/farm.dart';
import 'dart:developer' as dev;

class FarmRepositoryImpl implements FarmRepository {
  final Dio _dio;

  FarmRepositoryImpl(this._dio);

  Map<String, dynamic> _toFarmJson(Map<String, dynamic> raw) {
    final lat = raw['location_latitude'];
    final lon = raw['location_longitude'];
    final location = (lat != null || lon != null) ? '$lat,$lon' : null;
    return {
      ...raw,
      'name': raw['farm_name'] ?? '',
      'location': location,
      'image_path': fixImageUrl(raw['image_url']?.toString()),
    };
  }

  Map<String, dynamic> _parseLocation(String? location) {
    if (location == null || location.trim().isEmpty) return {};
    final parts = location.split(',');
    if (parts.length != 2) return {};
    final lat = double.tryParse(parts[0].trim());
    final lon = double.tryParse(parts[1].trim());
    if (lat == null || lon == null) return {};
    return {
      'location_latitude': lat,
      'location_longitude': lon,
    };
  }

  @override
  Future<List<Farm>> getFarms({int? limit, int? offset}) async {
    try {
      final response = await _dio.get('/farms', queryParameters: {
        if (limit != null) 'limit': limit,
        if (offset != null) 'offset': offset,
      });
      
      dev.log("GET FARMS RESPONSE: ${response.data}", name: 'FarmRepository');
      final list = ApiUtils.extractWrappedList(response.data, keys: ['farms']);
      return list
          .whereType<Map<String, dynamic>>()
          .map((e) => Farm.fromJson(_toFarmJson(e)))
          .toList();
    } catch (e) {
      dev.log("Error in getFarms: $e", name: 'FarmRepository', error: e);
      rethrow;
    }
  }

  @override
  Future<Farm> getFarmById(int id) async {
    final response = await _dio.get('/farms/$id');
    final map = ApiUtils.extractMap(response.data);
    return Farm.fromJson(_toFarmJson(map));
  }

  @override
  Future<Farm> createFarm(String name, {String? location, String? address}) async {
    final response = await _dio.post('/farms', data: {
      'farm_name': name,
      'address': address,
      ..._parseLocation(location),
    });
    final map = ApiUtils.extractMap(response.data);
    return Farm.fromJson(_toFarmJson(map));
  }

  @override
  Future<Farm> updateFarm(int id, String name, {String? location, String? address}) async {
    final response = await _dio.put('/farms/$id', data: {
      'farm_name': name,
      'address': address,
      ..._parseLocation(location),
    });
    final map = ApiUtils.extractMap(response.data);
    return Farm.fromJson(_toFarmJson(map));
  }

  @override
  Future<void> deleteFarm(int id) async {
    await _dio.delete('/farms/$id');
  }

  @override
  Future<void> uploadFarmImage(int farmId, File imageFile) async {
    String fileName = imageFile.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(imageFile.path, filename: fileName),
    });
    await _dio.post('/farms/$farmId/image', data: formData);
  }

  @override
  Future<Map<String, dynamic>> getLiveSensorData(int farmId, {int samples = 5}) async {
    try {
      final response = await _dio.get('/farms/$farmId/live-sensor-data', queryParameters: {
        'samples': samples,
      });
      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }
      return {'status': 'success', 'data': response.data};
    } on DioException catch (e) {
      if (e.response != null && e.response?.data is Map) {
        final data = e.response!.data as Map;
        final msg = data['message']?.toString() ?? 'Failed to fetch live sensor data';
        throw Exception(msg);
      }
      rethrow;
    }
  }
}
