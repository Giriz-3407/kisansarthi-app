import 'package:freezed_annotation/freezed_annotation.dart';

part 'recommendations.freezed.dart';
part 'recommendations.g.dart';

@freezed
class CropItem with _$CropItem {
  const factory CropItem({
    required String crop,
    required double confidence,
  }) = _CropItem;

  factory CropItem.fromJson(Map<String, dynamic> json) => _$CropItemFromJson(json);
}

@freezed
class CropSuggestion with _$CropSuggestion {
  const factory CropSuggestion({
    @JsonKey(name: 'crop_name') required String cropName,
    required double match,
    @JsonKey(name: 'top_crops') @Default(<CropItem>[]) List<CropItem> topCrops,
    @JsonKey(name: 'primary_crop') required CropItem primaryCrop,
    String? reason,
    String? explanation,
    @JsonKey(name: 'expected_yield') String? expectedYield,
  }) = _CropSuggestion;

  factory CropSuggestion.fromJson(Map<String, dynamic> json) => _$CropSuggestionFromJson(json);
}

@freezed
class FertilizerRecommendation with _$FertilizerRecommendation {
  const factory FertilizerRecommendation({
    @JsonKey(name: 'fertilizer_name') required String fertilizerName,
    required String dosage,
    String? explanation,
    String? advisory,
    @JsonKey(name: 'buy_at') String? buyAt,
    double? price,
  }) = _FertilizerRecommendation;

  factory FertilizerRecommendation.fromJson(Map<String, dynamic> json) => _$FertilizerRecommendationFromJson(json);
}
