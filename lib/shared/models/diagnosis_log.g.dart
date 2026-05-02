// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnosis_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiagnosisLogImpl _$$DiagnosisLogImplFromJson(Map<String, dynamic> json) =>
    _$DiagnosisLogImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      landId: (json['land_id'] as num?)?.toInt(),
      imagePath: json['image_path'] as String?,
      diseaseName: json['disease_name'] as String?,
      confidence: (json['confidence'] as num?)?.toDouble(),
      symptoms: json['symptoms'] as String?,
      remedies: (json['remedies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      prevention: json['prevention'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$$DiagnosisLogImplToJson(_$DiagnosisLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'land_id': instance.landId,
      'image_path': instance.imagePath,
      'disease_name': instance.diseaseName,
      'confidence': instance.confidence,
      'symptoms': instance.symptoms,
      'remedies': instance.remedies,
      'prevention': instance.prevention,
      'status': instance.status,
      'created_at': instance.createdAt,
    };
