import 'package:kisansarthi/shared/models/recommendations.dart';

abstract class RecommendationRepository {
  Future<List<CropSuggestion>> getCropSuggestions(int landId, {String? lang});
  Future<List<FertilizerRecommendation>> getFertilizerRecommendations(
    int landId, {
    String? lang,
    required int soilColor,
    required String cropName,
  });
}
