import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:kisansarthi/shared/models/planting.dart';

part 'land.freezed.dart';
part 'land.g.dart';

@freezed
class Land with _$Land {
  const factory Land({
    required int id,
    @JsonKey(name: 'farm_id') required int farmId,
    required String name,
    @JsonKey(name: 'land_type') String? landType,
    double? area,
    @JsonKey(name: 'area_unit') String? areaUnit,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'current_planting') Planting? currentPlanting,
  }) = _Land;

  factory Land.fromJson(Map<String, dynamic> json) => _$LandFromJson(json);
}
