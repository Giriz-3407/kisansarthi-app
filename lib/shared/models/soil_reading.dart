import 'package:freezed_annotation/freezed_annotation.dart';

part 'soil_reading.freezed.dart';
part 'soil_reading.g.dart';

@freezed
class SoilReading with _$SoilReading {
  const factory SoilReading({
    required int id,
    @JsonKey(name: 'land_id') int? landId,
    @JsonKey(name: 'device_id') int? deviceId,
    double? nitrogen,
    double? phosphorus,
    double? potassium,
    double? ph,
    double? temperature,
    double? humidity,
    double? rainfall,
    @JsonKey(name: 'reading_type') String? readingType,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _SoilReading;

  factory SoilReading.fromJson(Map<String, dynamic> json) => _$SoilReadingFromJson(json);
}
