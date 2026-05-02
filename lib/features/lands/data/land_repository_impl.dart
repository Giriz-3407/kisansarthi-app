import 'package:dio/dio.dart';
import 'package:kisansarthi/core/network/api_utils.dart';
import 'package:kisansarthi/features/lands/domain/land_repository.dart';
import 'package:kisansarthi/shared/models/land.dart';
import 'dart:developer' as dev;

class LandRepositoryImpl implements LandRepository {
  final Dio _dio;

  LandRepositoryImpl(this._dio);

  Map<String, dynamic> _toLandJson(Map<String, dynamic> raw) {
    final currentPlanting = raw['current_planting'];
    final normalizedPlanting = currentPlanting is Map<String, dynamic>
        ? {
            ...currentPlanting,
            'land_id': currentPlanting['land_id'] ?? raw['id'],
            'crop_name': currentPlanting['crop_name'] ??
                (currentPlanting['crop'] is Map<String, dynamic>
                    ? currentPlanting['crop']['crop_name']
                    : null),
          }
        : currentPlanting;

    return {
      ...raw,
      'name': raw['land_name'] ?? '',
      'land_type': raw['soil_type_manual'],
      'current_planting': normalizedPlanting,
    };
  }

  @override
  Future<List<Land>> getLandsByFarm(int farmId, {int? limit, int? offset}) async {
    final response = await _dio.get('/farms/$farmId/lands', queryParameters: {
      if (limit != null) 'limit': limit,
      if (offset != null) 'offset': offset,
    });
    final list = ApiUtils.extractWrappedList(response.data, keys: ['lands']);
    return list
        .whereType<Map<String, dynamic>>()
        .map((e) => Land.fromJson(_toLandJson(e)))
        .toList();
  }

  @override
  Future<Land> getLandById(int id) async {
    final response = await _dio.get('/lands/$id');
    final map = ApiUtils.extractMap(response.data);
    return Land.fromJson(_toLandJson(map));
  }

  @override
  Future<Land> createLand(int farmId, String name, {String? landType, double? area, String? areaUnit}) async {
    final payload = {
      'land_name': name,
      'soil_type_manual': landType,
      'area': area,
      'area_unit': areaUnit,
    };
    dev.log('ADD LAND PAYLOAD: $payload', name: 'LandRepository');
    try {
      final response = await _dio.post('/farms/$farmId/lands', data: payload);
      final map = ApiUtils.extractMap(response.data);
      return Land.fromJson(_toLandJson(map));
    } on DioException catch (e) {
      dev.log('ADD LAND ERROR RESPONSE: ${e.response?.data}', name: 'LandRepository');
      rethrow;
    }
  }

  @override
  Future<Land> updateLand(int id, String name, {String? landType, double? area, String? areaUnit}) async {
    final response = await _dio.put('/lands/$id', data: {
      'land_name': name,
      'soil_type_manual': landType,
      'area': area,
      'area_unit': areaUnit,
    });
    final map = ApiUtils.extractMap(response.data);
    return Land.fromJson(_toLandJson(map));
  }

  @override
  Future<void> deleteLand(int id) async {
    await _dio.delete('/lands/$id');
  }
}
