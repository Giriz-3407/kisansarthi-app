// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FarmImpl _$$FarmImplFromJson(Map<String, dynamic> json) => _$FarmImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  location: json['location'] as String?,
  address: json['address'] as String?,
  imagePath: json['image_path'] as String?,
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$$FarmImplToJson(_$FarmImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'address': instance.address,
      'image_path': instance.imagePath,
      'created_at': instance.createdAt,
    };
