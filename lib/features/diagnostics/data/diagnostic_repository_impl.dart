import 'dart:io';
import 'package:dio/dio.dart';
import 'package:kisansarthi/core/network/api_utils.dart';
import 'package:kisansarthi/core/network/image_url.dart';
import 'package:kisansarthi/features/diagnostics/domain/diagnostic_repository.dart';

class DiagnosticRepositoryImpl implements DiagnosticRepository {
  Map<String, dynamic> _normalizeLog(Map<String, dynamic> raw) {
    final disease = raw['detected_disease'];
    String? diseaseName;
    String? symptoms;
    String? prevention;
    if (disease is Map<String, dynamic>) {
      diseaseName = disease['disease_name']?.toString();
      symptoms = disease['symptoms']?.toString();
      prevention = disease['description']?.toString();
    }

    final remediesRaw = raw['remedies'];
    final remedies = <String>[];
    if (remediesRaw is List) {
      for (final item in remediesRaw) {
        if (item is Map<String, dynamic>) {
          final desc = item['description']?.toString();
          if (desc != null && desc.isNotEmpty) remedies.add(desc);
        } else if (item != null) {
          remedies.add(item.toString());
        }
      }
    }

    return {
      ...raw,
      'id': raw['id'] ?? raw['log_id'],
      'status': raw['processing_status']?.toString() ?? raw['status']?.toString() ?? 'pending',
      'disease_name': diseaseName ?? 'Diagnosis pending',
      'confidence': (raw['confidence_score'] as num?)?.toDouble() ?? 0.0,
      'image_path': fixImageUrl(raw['image_storage_url']?.toString() ?? raw['image_url']?.toString()),
      'symptoms': symptoms,
      'prevention': prevention,
      'remedies': remedies,
    };
  }

  final Dio _dio;

  DiagnosticRepositoryImpl(this._dio);

  @override
  Future<int> scanPlant(
    File imageFile, {
    int? landId,
    int? plantingId,
    String? cropName,
    String? lang,
  }) async {
    if (cropName != null &&
        (cropName.trim().isEmpty || cropName.trim().toLowerCase() == 'unknown')) {
      throw ArgumentError('A valid selected crop is required.');
    }

    String fileName = imageFile.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(imageFile.path, filename: fileName),
      if (landId != null) "land_id": landId.toString(),
      if (plantingId != null) "planting_id": plantingId.toString(),
      if (cropName != null) "crop_name": cropName,
      if (lang != null) "lang": lang,
    });

    final response = await _dio.post(
      '/diagnostics/scan-plant',
      data: formData,
      options: Options(
        receiveTimeout: const Duration(seconds: 120),
      ),
    );
    final map = ApiUtils.extractMap(response.data);
    return (map['log_id'] as num).toInt();
  }

  @override
  Future<Map<String, dynamic>> getDiagnosticLog(int logId) async {
    final response = await _dio.get('/diagnostics/logs/$logId');
    final map = ApiUtils.extractMap(response.data);
    return _normalizeLog(map);
  }

  @override
  Future<List<Map<String, dynamic>>> getDiagnosticLogs() async {
    final response = await _dio.get('/diagnostics/logs');
    final list = ApiUtils.extractWrappedList(response.data, keys: ['logs']);
    return list.whereType<Map<String, dynamic>>().map(_normalizeLog).toList();
  }
}
