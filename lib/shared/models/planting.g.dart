// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlantingImpl _$$PlantingImplFromJson(Map<String, dynamic> json) =>
    _$PlantingImpl(
      id: (json['id'] as num).toInt(),
      landId: (json['land_id'] as num).toInt(),
      cropName: json['crop_name'] as String,
      plantingDate: json['planting_date'] as String?,
      harvestDate: json['harvest_date'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$$PlantingImplToJson(_$PlantingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'land_id': instance.landId,
      'crop_name': instance.cropName,
      'planting_date': instance.plantingDate,
      'harvest_date': instance.harvestDate,
      'status': instance.status,
      'created_at': instance.createdAt,
    };
