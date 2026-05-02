// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hardware_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HardwareDeviceImpl _$$HardwareDeviceImplFromJson(Map<String, dynamic> json) =>
    _$HardwareDeviceImpl(
      id: (json['id'] as num).toInt(),
      deviceSerial: json['device_serial'] as String,
      deviceType: json['device_type'] as String?,
      landId: (json['land_id'] as num?)?.toInt(),
      farmId: (json['farm_id'] as num?)?.toInt(),
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$$HardwareDeviceImplToJson(
  _$HardwareDeviceImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'device_serial': instance.deviceSerial,
  'device_type': instance.deviceType,
  'land_id': instance.landId,
  'farm_id': instance.farmId,
  'status': instance.status,
  'created_at': instance.createdAt,
};
