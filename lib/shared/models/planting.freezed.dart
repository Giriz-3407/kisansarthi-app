// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Planting _$PlantingFromJson(Map<String, dynamic> json) {
  return _Planting.fromJson(json);
}

/// @nodoc
mixin _$Planting {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'land_id')
  int get landId => throw _privateConstructorUsedError;
  @JsonKey(name: 'crop_name')
  String get cropName => throw _privateConstructorUsedError;
  @JsonKey(name: 'planting_date')
  String? get plantingDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'harvest_date')
  String? get harvestDate => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Planting to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Planting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlantingCopyWith<Planting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlantingCopyWith<$Res> {
  factory $PlantingCopyWith(Planting value, $Res Function(Planting) then) =
      _$PlantingCopyWithImpl<$Res, Planting>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'land_id') int landId,
    @JsonKey(name: 'crop_name') String cropName,
    @JsonKey(name: 'planting_date') String? plantingDate,
    @JsonKey(name: 'harvest_date') String? harvestDate,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class _$PlantingCopyWithImpl<$Res, $Val extends Planting>
    implements $PlantingCopyWith<$Res> {
  _$PlantingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Planting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? landId = null,
    Object? cropName = null,
    Object? plantingDate = freezed,
    Object? harvestDate = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            landId: null == landId
                ? _value.landId
                : landId // ignore: cast_nullable_to_non_nullable
                      as int,
            cropName: null == cropName
                ? _value.cropName
                : cropName // ignore: cast_nullable_to_non_nullable
                      as String,
            plantingDate: freezed == plantingDate
                ? _value.plantingDate
                : plantingDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            harvestDate: freezed == harvestDate
                ? _value.harvestDate
                : harvestDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlantingImplCopyWith<$Res>
    implements $PlantingCopyWith<$Res> {
  factory _$$PlantingImplCopyWith(
    _$PlantingImpl value,
    $Res Function(_$PlantingImpl) then,
  ) = __$$PlantingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'land_id') int landId,
    @JsonKey(name: 'crop_name') String cropName,
    @JsonKey(name: 'planting_date') String? plantingDate,
    @JsonKey(name: 'harvest_date') String? harvestDate,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class __$$PlantingImplCopyWithImpl<$Res>
    extends _$PlantingCopyWithImpl<$Res, _$PlantingImpl>
    implements _$$PlantingImplCopyWith<$Res> {
  __$$PlantingImplCopyWithImpl(
    _$PlantingImpl _value,
    $Res Function(_$PlantingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Planting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? landId = null,
    Object? cropName = null,
    Object? plantingDate = freezed,
    Object? harvestDate = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$PlantingImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        landId: null == landId
            ? _value.landId
            : landId // ignore: cast_nullable_to_non_nullable
                  as int,
        cropName: null == cropName
            ? _value.cropName
            : cropName // ignore: cast_nullable_to_non_nullable
                  as String,
        plantingDate: freezed == plantingDate
            ? _value.plantingDate
            : plantingDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        harvestDate: freezed == harvestDate
            ? _value.harvestDate
            : harvestDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlantingImpl implements _Planting {
  const _$PlantingImpl({
    required this.id,
    @JsonKey(name: 'land_id') required this.landId,
    @JsonKey(name: 'crop_name') required this.cropName,
    @JsonKey(name: 'planting_date') this.plantingDate,
    @JsonKey(name: 'harvest_date') this.harvestDate,
    this.status,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$PlantingImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlantingImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'land_id')
  final int landId;
  @override
  @JsonKey(name: 'crop_name')
  final String cropName;
  @override
  @JsonKey(name: 'planting_date')
  final String? plantingDate;
  @override
  @JsonKey(name: 'harvest_date')
  final String? harvestDate;
  @override
  final String? status;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @override
  String toString() {
    return 'Planting(id: $id, landId: $landId, cropName: $cropName, plantingDate: $plantingDate, harvestDate: $harvestDate, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlantingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.landId, landId) || other.landId == landId) &&
            (identical(other.cropName, cropName) ||
                other.cropName == cropName) &&
            (identical(other.plantingDate, plantingDate) ||
                other.plantingDate == plantingDate) &&
            (identical(other.harvestDate, harvestDate) ||
                other.harvestDate == harvestDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    landId,
    cropName,
    plantingDate,
    harvestDate,
    status,
    createdAt,
  );

  /// Create a copy of Planting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlantingImplCopyWith<_$PlantingImpl> get copyWith =>
      __$$PlantingImplCopyWithImpl<_$PlantingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlantingImplToJson(this);
  }
}

abstract class _Planting implements Planting {
  const factory _Planting({
    required final int id,
    @JsonKey(name: 'land_id') required final int landId,
    @JsonKey(name: 'crop_name') required final String cropName,
    @JsonKey(name: 'planting_date') final String? plantingDate,
    @JsonKey(name: 'harvest_date') final String? harvestDate,
    final String? status,
    @JsonKey(name: 'created_at') final String? createdAt,
  }) = _$PlantingImpl;

  factory _Planting.fromJson(Map<String, dynamic> json) =
      _$PlantingImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'land_id')
  int get landId;
  @override
  @JsonKey(name: 'crop_name')
  String get cropName;
  @override
  @JsonKey(name: 'planting_date')
  String? get plantingDate;
  @override
  @JsonKey(name: 'harvest_date')
  String? get harvestDate;
  @override
  String? get status;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;

  /// Create a copy of Planting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlantingImplCopyWith<_$PlantingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
