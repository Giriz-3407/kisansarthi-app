// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'land.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Land _$LandFromJson(Map<String, dynamic> json) {
  return _Land.fromJson(json);
}

/// @nodoc
mixin _$Land {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'farm_id')
  int get farmId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'land_type')
  String? get landType => throw _privateConstructorUsedError;
  double? get area => throw _privateConstructorUsedError;
  @JsonKey(name: 'area_unit')
  String? get areaUnit => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_planting')
  Planting? get currentPlanting => throw _privateConstructorUsedError;

  /// Serializes this Land to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Land
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LandCopyWith<Land> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LandCopyWith<$Res> {
  factory $LandCopyWith(Land value, $Res Function(Land) then) =
      _$LandCopyWithImpl<$Res, Land>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'farm_id') int farmId,
    String name,
    @JsonKey(name: 'land_type') String? landType,
    double? area,
    @JsonKey(name: 'area_unit') String? areaUnit,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'current_planting') Planting? currentPlanting,
  });

  $PlantingCopyWith<$Res>? get currentPlanting;
}

/// @nodoc
class _$LandCopyWithImpl<$Res, $Val extends Land>
    implements $LandCopyWith<$Res> {
  _$LandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Land
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? farmId = null,
    Object? name = null,
    Object? landType = freezed,
    Object? area = freezed,
    Object? areaUnit = freezed,
    Object? createdAt = freezed,
    Object? currentPlanting = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            farmId: null == farmId
                ? _value.farmId
                : farmId // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            landType: freezed == landType
                ? _value.landType
                : landType // ignore: cast_nullable_to_non_nullable
                      as String?,
            area: freezed == area
                ? _value.area
                : area // ignore: cast_nullable_to_non_nullable
                      as double?,
            areaUnit: freezed == areaUnit
                ? _value.areaUnit
                : areaUnit // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentPlanting: freezed == currentPlanting
                ? _value.currentPlanting
                : currentPlanting // ignore: cast_nullable_to_non_nullable
                      as Planting?,
          )
          as $Val,
    );
  }

  /// Create a copy of Land
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlantingCopyWith<$Res>? get currentPlanting {
    if (_value.currentPlanting == null) {
      return null;
    }

    return $PlantingCopyWith<$Res>(_value.currentPlanting!, (value) {
      return _then(_value.copyWith(currentPlanting: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LandImplCopyWith<$Res> implements $LandCopyWith<$Res> {
  factory _$$LandImplCopyWith(
    _$LandImpl value,
    $Res Function(_$LandImpl) then,
  ) = __$$LandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'farm_id') int farmId,
    String name,
    @JsonKey(name: 'land_type') String? landType,
    double? area,
    @JsonKey(name: 'area_unit') String? areaUnit,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'current_planting') Planting? currentPlanting,
  });

  @override
  $PlantingCopyWith<$Res>? get currentPlanting;
}

/// @nodoc
class __$$LandImplCopyWithImpl<$Res>
    extends _$LandCopyWithImpl<$Res, _$LandImpl>
    implements _$$LandImplCopyWith<$Res> {
  __$$LandImplCopyWithImpl(_$LandImpl _value, $Res Function(_$LandImpl) _then)
    : super(_value, _then);

  /// Create a copy of Land
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? farmId = null,
    Object? name = null,
    Object? landType = freezed,
    Object? area = freezed,
    Object? areaUnit = freezed,
    Object? createdAt = freezed,
    Object? currentPlanting = freezed,
  }) {
    return _then(
      _$LandImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        farmId: null == farmId
            ? _value.farmId
            : farmId // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        landType: freezed == landType
            ? _value.landType
            : landType // ignore: cast_nullable_to_non_nullable
                  as String?,
        area: freezed == area
            ? _value.area
            : area // ignore: cast_nullable_to_non_nullable
                  as double?,
        areaUnit: freezed == areaUnit
            ? _value.areaUnit
            : areaUnit // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentPlanting: freezed == currentPlanting
            ? _value.currentPlanting
            : currentPlanting // ignore: cast_nullable_to_non_nullable
                  as Planting?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LandImpl implements _Land {
  const _$LandImpl({
    required this.id,
    @JsonKey(name: 'farm_id') required this.farmId,
    required this.name,
    @JsonKey(name: 'land_type') this.landType,
    this.area,
    @JsonKey(name: 'area_unit') this.areaUnit,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'current_planting') this.currentPlanting,
  });

  factory _$LandImpl.fromJson(Map<String, dynamic> json) =>
      _$$LandImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'farm_id')
  final int farmId;
  @override
  final String name;
  @override
  @JsonKey(name: 'land_type')
  final String? landType;
  @override
  final double? area;
  @override
  @JsonKey(name: 'area_unit')
  final String? areaUnit;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'current_planting')
  final Planting? currentPlanting;

  @override
  String toString() {
    return 'Land(id: $id, farmId: $farmId, name: $name, landType: $landType, area: $area, areaUnit: $areaUnit, createdAt: $createdAt, currentPlanting: $currentPlanting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LandImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.farmId, farmId) || other.farmId == farmId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.landType, landType) ||
                other.landType == landType) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.areaUnit, areaUnit) ||
                other.areaUnit == areaUnit) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.currentPlanting, currentPlanting) ||
                other.currentPlanting == currentPlanting));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    farmId,
    name,
    landType,
    area,
    areaUnit,
    createdAt,
    currentPlanting,
  );

  /// Create a copy of Land
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LandImplCopyWith<_$LandImpl> get copyWith =>
      __$$LandImplCopyWithImpl<_$LandImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LandImplToJson(this);
  }
}

abstract class _Land implements Land {
  const factory _Land({
    required final int id,
    @JsonKey(name: 'farm_id') required final int farmId,
    required final String name,
    @JsonKey(name: 'land_type') final String? landType,
    final double? area,
    @JsonKey(name: 'area_unit') final String? areaUnit,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'current_planting') final Planting? currentPlanting,
  }) = _$LandImpl;

  factory _Land.fromJson(Map<String, dynamic> json) = _$LandImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'farm_id')
  int get farmId;
  @override
  String get name;
  @override
  @JsonKey(name: 'land_type')
  String? get landType;
  @override
  double? get area;
  @override
  @JsonKey(name: 'area_unit')
  String? get areaUnit;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'current_planting')
  Planting? get currentPlanting;

  /// Create a copy of Land
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LandImplCopyWith<_$LandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
