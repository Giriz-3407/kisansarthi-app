// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'soil_reading.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SoilReadingImpl _$$SoilReadingImplFromJson(Map<String, dynamic> json) =>
    _$SoilReadingImpl(
      id: (json['id'] as num).toInt(),
      landId: (json['land_id'] as num?)?.toInt(),
      deviceId: (json['device_id'] as num?)?.toInt(),
      nitrogen: (json['nitrogen'] as num?)?.toDouble(),
      phosphorus: (json['phosphorus'] as num?)?.toDouble(),
      potassium: (json['potassium'] as num?)?.toDouble(),
      ph: (json['ph'] as num?)?.toDouble(),
      moisture: (json['moisture'] as num?)?.toDouble(),
      temperature: (json['temperature'] as num?)?.toDouble(),
      humidity: (json['humidity'] as num?)?.toDouble(),
      rainfall: (json['rainfall'] as num?)?.toDouble(),
      readingType: json['reading_type'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$$SoilReadingImplToJson(_$SoilReadingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'land_id': instance.landId,
      'device_id': instance.deviceId,
      'nitrogen': instance.nitrogen,
      'phosphorus': instance.phosphorus,
      'potassium': instance.potassium,
      'ph': instance.ph,
      'moisture': instance.moisture,
      'temperature': instance.temperature,
      'humidity': instance.humidity,
      'rainfall': instance.rainfall,
      'reading_type': instance.readingType,
      'created_at': instance.createdAt,
    };
