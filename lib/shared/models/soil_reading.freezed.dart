// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'soil_reading.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SoilReading _$SoilReadingFromJson(Map<String, dynamic> json) {
  return _SoilReading.fromJson(json);
}

/// @nodoc
mixin _$SoilReading {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'land_id')
  int? get landId => throw _privateConstructorUsedError;
  @JsonKey(name: 'device_id')
  int? get deviceId => throw _privateConstructorUsedError;
  double? get nitrogen => throw _privateConstructorUsedError;
  double? get phosphorus => throw _privateConstructorUsedError;
  double? get potassium => throw _privateConstructorUsedError;
  double? get ph => throw _privateConstructorUsedError;
  double? get moisture => throw _privateConstructorUsedError;
  double? get temperature => throw _privateConstructorUsedError;
  double? get humidity => throw _privateConstructorUsedError;
  double? get rainfall => throw _privateConstructorUsedError;
  @JsonKey(name: 'reading_type')
  String? get readingType => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this SoilReading to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SoilReading
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SoilReadingCopyWith<SoilReading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SoilReadingCopyWith<$Res> {
  factory $SoilReadingCopyWith(
    SoilReading value,
    $Res Function(SoilReading) then,
  ) = _$SoilReadingCopyWithImpl<$Res, SoilReading>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'land_id') int? landId,
    @JsonKey(name: 'device_id') int? deviceId,
    double? nitrogen,
    double? phosphorus,
    double? potassium,
    double? ph,
    double? moisture,
    double? temperature,
    double? humidity,
    double? rainfall,
    @JsonKey(name: 'reading_type') String? readingType,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class _$SoilReadingCopyWithImpl<$Res, $Val extends SoilReading>
    implements $SoilReadingCopyWith<$Res> {
  _$SoilReadingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SoilReading
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? landId = freezed,
    Object? deviceId = freezed,
    Object? nitrogen = freezed,
    Object? phosphorus = freezed,
    Object? potassium = freezed,
    Object? ph = freezed,
    Object? moisture = freezed,
    Object? temperature = freezed,
    Object? humidity = freezed,
    Object? rainfall = freezed,
    Object? readingType = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            landId: freezed == landId
                ? _value.landId
                : landId // ignore: cast_nullable_to_non_nullable
                      as int?,
            deviceId: freezed == deviceId
                ? _value.deviceId
                : deviceId // ignore: cast_nullable_to_non_nullable
                      as int?,
            nitrogen: freezed == nitrogen
                ? _value.nitrogen
                : nitrogen // ignore: cast_nullable_to_non_nullable
                      as double?,
            phosphorus: freezed == phosphorus
                ? _value.phosphorus
                : phosphorus // ignore: cast_nullable_to_non_nullable
                      as double?,
            potassium: freezed == potassium
                ? _value.potassium
                : potassium // ignore: cast_nullable_to_non_nullable
                      as double?,
            ph: freezed == ph
                ? _value.ph
                : ph // ignore: cast_nullable_to_non_nullable
                      as double?,
            moisture: freezed == moisture
                ? _value.moisture
                : moisture // ignore: cast_nullable_to_non_nullable
                      as double?,
            temperature: freezed == temperature
                ? _value.temperature
                : temperature // ignore: cast_nullable_to_non_nullable
                      as double?,
            humidity: freezed == humidity
                ? _value.humidity
                : humidity // ignore: cast_nullable_to_non_nullable
                      as double?,
            rainfall: freezed == rainfall
                ? _value.rainfall
                : rainfall // ignore: cast_nullable_to_non_nullable
                      as double?,
            readingType: freezed == readingType
                ? _value.readingType
                : readingType // ignore: cast_nullable_to_non_nullable
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
abstract class _$$SoilReadingImplCopyWith<$Res>
    implements $SoilReadingCopyWith<$Res> {
  factory _$$SoilReadingImplCopyWith(
    _$SoilReadingImpl value,
    $Res Function(_$SoilReadingImpl) then,
  ) = __$$SoilReadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'land_id') int? landId,
    @JsonKey(name: 'device_id') int? deviceId,
    double? nitrogen,
    double? phosphorus,
    double? potassium,
    double? ph,
    double? moisture,
    double? temperature,
    double? humidity,
    double? rainfall,
    @JsonKey(name: 'reading_type') String? readingType,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class __$$SoilReadingImplCopyWithImpl<$Res>
    extends _$SoilReadingCopyWithImpl<$Res, _$SoilReadingImpl>
    implements _$$SoilReadingImplCopyWith<$Res> {
  __$$SoilReadingImplCopyWithImpl(
    _$SoilReadingImpl _value,
    $Res Function(_$SoilReadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SoilReading
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? landId = freezed,
    Object? deviceId = freezed,
    Object? nitrogen = freezed,
    Object? phosphorus = freezed,
    Object? potassium = freezed,
    Object? ph = freezed,
    Object? moisture = freezed,
    Object? temperature = freezed,
    Object? humidity = freezed,
    Object? rainfall = freezed,
    Object? readingType = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$SoilReadingImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        landId: freezed == landId
            ? _value.landId
            : landId // ignore: cast_nullable_to_non_nullable
                  as int?,
        deviceId: freezed == deviceId
            ? _value.deviceId
            : deviceId // ignore: cast_nullable_to_non_nullable
                  as int?,
        nitrogen: freezed == nitrogen
            ? _value.nitrogen
            : nitrogen // ignore: cast_nullable_to_non_nullable
                  as double?,
        phosphorus: freezed == phosphorus
            ? _value.phosphorus
            : phosphorus // ignore: cast_nullable_to_non_nullable
                  as double?,
        potassium: freezed == potassium
            ? _value.potassium
            : potassium // ignore: cast_nullable_to_non_nullable
                  as double?,
        ph: freezed == ph
            ? _value.ph
            : ph // ignore: cast_nullable_to_non_nullable
                  as double?,
        moisture: freezed == moisture
            ? _value.moisture
            : moisture // ignore: cast_nullable_to_non_nullable
                  as double?,
        temperature: freezed == temperature
            ? _value.temperature
            : temperature // ignore: cast_nullable_to_non_nullable
                  as double?,
        humidity: freezed == humidity
            ? _value.humidity
            : humidity // ignore: cast_nullable_to_non_nullable
                  as double?,
        rainfall: freezed == rainfall
            ? _value.rainfall
            : rainfall // ignore: cast_nullable_to_non_nullable
                  as double?,
        readingType: freezed == readingType
            ? _value.readingType
            : readingType // ignore: cast_nullable_to_non_nullable
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
class _$SoilReadingImpl implements _SoilReading {
  const _$SoilReadingImpl({
    required this.id,
    @JsonKey(name: 'land_id') this.landId,
    @JsonKey(name: 'device_id') this.deviceId,
    this.nitrogen,
    this.phosphorus,
    this.potassium,
    this.ph,
    this.moisture,
    this.temperature,
    this.humidity,
    this.rainfall,
    @JsonKey(name: 'reading_type') this.readingType,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$SoilReadingImpl.fromJson(Map<String, dynamic> json) =>
      _$$SoilReadingImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'land_id')
  final int? landId;
  @override
  @JsonKey(name: 'device_id')
  final int? deviceId;
  @override
  final double? nitrogen;
  @override
  final double? phosphorus;
  @override
  final double? potassium;
  @override
  final double? ph;
  @override
  final double? moisture;
  @override
  final double? temperature;
  @override
  final double? humidity;
  @override
  final double? rainfall;
  @override
  @JsonKey(name: 'reading_type')
  final String? readingType;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @override
  String toString() {
    return 'SoilReading(id: $id, landId: $landId, deviceId: $deviceId, nitrogen: $nitrogen, phosphorus: $phosphorus, potassium: $potassium, ph: $ph, moisture: $moisture, temperature: $temperature, humidity: $humidity, rainfall: $rainfall, readingType: $readingType, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SoilReadingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.landId, landId) || other.landId == landId) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.nitrogen, nitrogen) ||
                other.nitrogen == nitrogen) &&
            (identical(other.phosphorus, phosphorus) ||
                other.phosphorus == phosphorus) &&
            (identical(other.potassium, potassium) ||
                other.potassium == potassium) &&
            (identical(other.ph, ph) || other.ph == ph) &&
            (identical(other.moisture, moisture) ||
                other.moisture == moisture) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.humidity, humidity) ||
                other.humidity == humidity) &&
            (identical(other.rainfall, rainfall) ||
                other.rainfall == rainfall) &&
            (identical(other.readingType, readingType) ||
                other.readingType == readingType) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    landId,
    deviceId,
    nitrogen,
    phosphorus,
    potassium,
    ph,
    moisture,
    temperature,
    humidity,
    rainfall,
    readingType,
    createdAt,
  );

  /// Create a copy of SoilReading
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SoilReadingImplCopyWith<_$SoilReadingImpl> get copyWith =>
      __$$SoilReadingImplCopyWithImpl<_$SoilReadingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SoilReadingImplToJson(this);
  }
}

abstract class _SoilReading implements SoilReading {
  const factory _SoilReading({
    required final int id,
    @JsonKey(name: 'land_id') final int? landId,
    @JsonKey(name: 'device_id') final int? deviceId,
    final double? nitrogen,
    final double? phosphorus,
    final double? potassium,
    final double? ph,
    final double? moisture,
    final double? temperature,
    final double? humidity,
    final double? rainfall,
    @JsonKey(name: 'reading_type') final String? readingType,
    @JsonKey(name: 'created_at') final String? createdAt,
  }) = _$SoilReadingImpl;

  factory _SoilReading.fromJson(Map<String, dynamic> json) =
      _$SoilReadingImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'land_id')
  int? get landId;
  @override
  @JsonKey(name: 'device_id')
  int? get deviceId;
  @override
  double? get nitrogen;
  @override
  double? get phosphorus;
  @override
  double? get potassium;
  @override
  double? get ph;
  @override
  double? get moisture;
  @override
  double? get temperature;
  @override
  double? get humidity;
  @override
  double? get rainfall;
  @override
  @JsonKey(name: 'reading_type')
  String? get readingType;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;

  /// Create a copy of SoilReading
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SoilReadingImplCopyWith<_$SoilReadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
