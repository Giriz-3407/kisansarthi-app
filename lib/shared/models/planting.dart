import 'package:freezed_annotation/freezed_annotation.dart';

part 'planting.freezed.dart';
part 'planting.g.dart';

@freezed
class Planting with _$Planting {
  const factory Planting({
    required int id,
    @JsonKey(name: 'land_id') required int landId,
    @JsonKey(name: 'crop_name') required String cropName,
    @JsonKey(name: 'planting_date') String? plantingDate,
    @JsonKey(name: 'harvest_date') String? harvestDate,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _Planting;

  factory Planting.fromJson(Map<String, dynamic> json) => _$PlantingFromJson(json);
}
