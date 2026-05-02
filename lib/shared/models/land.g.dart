// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'land.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LandImpl _$$LandImplFromJson(Map<String, dynamic> json) => _$LandImpl(
  id: (json['id'] as num).toInt(),
  farmId: (json['farm_id'] as num).toInt(),
  name: json['name'] as String,
  landType: json['land_type'] as String?,
  area: (json['area'] as num?)?.toDouble(),
  areaUnit: json['area_unit'] as String?,
  createdAt: json['created_at'] as String?,
  currentPlanting: json['current_planting'] == null
      ? null
      : Planting.fromJson(json['current_planting'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$LandImplToJson(_$LandImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'farm_id': instance.farmId,
      'name': instance.name,
      'land_type': instance.landType,
      'area': instance.area,
      'area_unit': instance.areaUnit,
      'created_at': instance.createdAt,
      'current_planting': instance.currentPlanting,
    };
