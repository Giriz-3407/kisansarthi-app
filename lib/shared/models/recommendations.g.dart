// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CropItemImpl _$$CropItemImplFromJson(Map<String, dynamic> json) =>
    _$CropItemImpl(
      crop: json['crop'] as String,
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$$CropItemImplToJson(_$CropItemImpl instance) =>
    <String, dynamic>{
      'crop': instance.crop,
      'confidence': instance.confidence,
    };

_$CropSuggestionImpl _$$CropSuggestionImplFromJson(Map<String, dynamic> json) =>
    _$CropSuggestionImpl(
      cropName: json['crop_name'] as String,
      match: (json['match'] as num).toDouble(),
      topCrops:
          (json['top_crops'] as List<dynamic>?)
              ?.map((e) => CropItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <CropItem>[],
      primaryCrop: CropItem.fromJson(
        json['primary_crop'] as Map<String, dynamic>,
      ),
      reason: json['reason'] as String?,
      explanation: json['explanation'] as String?,
      expectedYield: json['expected_yield'] as String?,
    );

Map<String, dynamic> _$$CropSuggestionImplToJson(
  _$CropSuggestionImpl instance,
) => <String, dynamic>{
  'crop_name': instance.cropName,
  'match': instance.match,
  'top_crops': instance.topCrops.map((e) => e.toJson()).toList(),
  'primary_crop': instance.primaryCrop.toJson(),
  'reason': instance.reason,
  'explanation': instance.explanation,
  'expected_yield': instance.expectedYield,
};

_$FertilizerRecommendationImpl _$$FertilizerRecommendationImplFromJson(
  Map<String, dynamic> json,
) => _$FertilizerRecommendationImpl(
  fertilizerName: json['fertilizer_name'] as String,
  dosage: json['dosage'] as String,
  explanation: json['explanation'] as String?,
  advisory: json['advisory'] as String?,
  buyAt: json['buy_at'] as String?,
  price: (json['price'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$FertilizerRecommendationImplToJson(
  _$FertilizerRecommendationImpl instance,
) => <String, dynamic>{
  'fertilizer_name': instance.fertilizerName,
  'dosage': instance.dosage,
  'explanation': instance.explanation,
  'advisory': instance.advisory,
  'buy_at': instance.buyAt,
  'price': instance.price,
};
