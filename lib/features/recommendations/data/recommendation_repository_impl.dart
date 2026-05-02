import 'package:dio/dio.dart';
import 'package:kisansarthi/core/network/api_utils.dart';
import 'package:kisansarthi/features/recommendations/domain/recommendation_repository.dart';
import 'package:kisansarthi/shared/models/recommendations.dart';

class RecommendationRepositoryImpl implements RecommendationRepository {
  final Dio _dio;

  RecommendationRepositoryImpl(this._dio);

  CropItem _cropItemFromDynamic(dynamic value, {String fallbackCrop = '', double fallbackConfidence = 0.0}) {
    if (value is Map<String, dynamic>) {
      return CropItem.fromJson({
        'crop': (value['crop'] ?? value['crop_name'] ?? value['name'] ?? fallbackCrop).toString(),
        'confidence': (value['confidence'] as num?)?.toDouble()
            ?? (value['match'] as num?)?.toDouble()
            ?? fallbackConfidence,
      });
    }
    return CropItem(crop: fallbackCrop, confidence: fallbackConfidence);
  }

  Map<String, dynamic> _toCropSuggestionJson(Map<String, dynamic> raw) {
    final crop = raw['crop'];
    final cropName = crop is Map<String, dynamic>
        ? (crop['crop_name'] ?? crop['name'] ?? '').toString()
        : (raw['crop_name'] ?? raw['Crop'] ?? raw['crop'] ?? '').toString();
    final match = (raw['suitability_score'] as num?)?.toDouble()
        ?? (raw['match'] as num?)?.toDouble()
        ?? (raw['Match'] as num?)?.toDouble()
        ?? 0.0;
    final topCrops = raw['top_crops'] is List
        ? (raw['top_crops'] as List)
            .map((e) => _cropItemFromDynamic(e, fallbackCrop: cropName, fallbackConfidence: match))
            .where((e) => e.crop.trim().isNotEmpty)
            .toList()
        : <CropItem>[];
    final fallbackTopCrops = topCrops.isNotEmpty
        ? topCrops
        : <CropItem>[CropItem(crop: cropName, confidence: match)];
    final primaryCrop = _cropItemFromDynamic(
      raw['primary_crop'],
      fallbackCrop: fallbackTopCrops.first.crop,
      fallbackConfidence: fallbackTopCrops.first.confidence,
    );

    return {
      'crop_name': cropName,
      'match': match,
      'top_crops': fallbackTopCrops.map((e) => e.toJson()).toList(),
      'primary_crop': primaryCrop.toJson(),
      'reason': raw['reason']?.toString(),
      'explanation': raw['reasoning']?.toString(),
      'expected_yield': raw['expected_yield']?.toString(),
    };
  }

  Map<String, dynamic> _toFertilizerJson(Map<String, dynamic> raw) {
    return {
      'fertilizer_name': raw['title']?.toString() ?? raw['fertilizer_name']?.toString() ?? 'Recommendation',
      'dosage': raw['amount']?.toString() ?? '',
      'explanation': raw['details']?.toString(),
      'advisory': raw['reasoning']?.toString(),
      'buy_at': raw['buyat']?.toString(),
      'price': double.tryParse(raw['price']?.toString() ?? ''),
    };
  }

  @override
  Future<List<CropSuggestion>> getCropSuggestions(int landId, {String? lang}) async {
    final response = await _dio.get('/lands/$landId/crop-suggestions', queryParameters: {
      if (lang != null) 'lang': lang,
    });
    final list = ApiUtils.extractWrappedList(response.data, keys: ['suggestions']);
    return list
        .whereType<Map<String, dynamic>>()
        .map((e) => CropSuggestion.fromJson(_toCropSuggestionJson(e)))
        .toList();
  }

  @override
  Future<List<FertilizerRecommendation>> getFertilizerRecommendations(
    int landId, {
    String? lang,
    required int soilColor,
    required String cropName,
  }) async {
    if (cropName.trim().isEmpty || cropName.trim().toLowerCase() == 'unknown') {
      throw ArgumentError('A valid selected crop is required.');
    }
    print("Mapped crop: $cropName");
    print("Encoded soil: $soilColor");
    final response = await _dio.get('/lands/$landId/fertilizer-recommendations', queryParameters: {
      if (lang != null) 'lang': lang,
      'soil_color': soilColor,
      'crop': cropName,
    });
    final list = ApiUtils.extractWrappedList(response.data, keys: ['recommendations']);
    return list
        .whereType<Map<String, dynamic>>()
        .map((e) => FertilizerRecommendation.fromJson(_toFertilizerJson(e)))
        .toList();
  }
}
