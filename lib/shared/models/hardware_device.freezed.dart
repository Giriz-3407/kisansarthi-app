// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hardware_device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HardwareDevice _$HardwareDeviceFromJson(Map<String, dynamic> json) {
  return _HardwareDevice.fromJson(json);
}

/// @nodoc
mixin _$HardwareDevice {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'device_serial')
  String get deviceSerial => throw _privateConstructorUsedError;
  @JsonKey(name: 'device_type')
  String? get deviceType => throw _privateConstructorUsedError;
  @JsonKey(name: 'land_id')
  int? get landId => throw _privateConstructorUsedError;
  @JsonKey(name: 'farm_id')
  int? get farmId => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this HardwareDevice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HardwareDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HardwareDeviceCopyWith<HardwareDevice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HardwareDeviceCopyWith<$Res> {
  factory $HardwareDeviceCopyWith(
    HardwareDevice value,
    $Res Function(HardwareDevice) then,
  ) = _$HardwareDeviceCopyWithImpl<$Res, HardwareDevice>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'device_serial') String deviceSerial,
    @JsonKey(name: 'device_type') String? deviceType,
    @JsonKey(name: 'land_id') int? landId,
    @JsonKey(name: 'farm_id') int? farmId,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class _$HardwareDeviceCopyWithImpl<$Res, $Val extends HardwareDevice>
    implements $HardwareDeviceCopyWith<$Res> {
  _$HardwareDeviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HardwareDevice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deviceSerial = null,
    Object? deviceType = freezed,
    Object? landId = freezed,
    Object? farmId = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            deviceSerial: null == deviceSerial
                ? _value.deviceSerial
                : deviceSerial // ignore: cast_nullable_to_non_nullable
                      as String,
            deviceType: freezed == deviceType
                ? _value.deviceType
                : deviceType // ignore: cast_nullable_to_non_nullable
                      as String?,
            landId: freezed == landId
                ? _value.landId
                : landId // ignore: cast_nullable_to_non_nullable
                      as int?,
            farmId: freezed == farmId
                ? _value.farmId
                : farmId // ignore: cast_nullable_to_non_nullable
                      as int?,
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
abstract class _$$HardwareDeviceImplCopyWith<$Res>
    implements $HardwareDeviceCopyWith<$Res> {
  factory _$$HardwareDeviceImplCopyWith(
    _$HardwareDeviceImpl value,
    $Res Function(_$HardwareDeviceImpl) then,
  ) = __$$HardwareDeviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'device_serial') String deviceSerial,
    @JsonKey(name: 'device_type') String? deviceType,
    @JsonKey(name: 'land_id') int? landId,
    @JsonKey(name: 'farm_id') int? farmId,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class __$$HardwareDeviceImplCopyWithImpl<$Res>
    extends _$HardwareDeviceCopyWithImpl<$Res, _$HardwareDeviceImpl>
    implements _$$HardwareDeviceImplCopyWith<$Res> {
  __$$HardwareDeviceImplCopyWithImpl(
    _$HardwareDeviceImpl _value,
    $Res Function(_$HardwareDeviceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HardwareDevice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deviceSerial = null,
    Object? deviceType = freezed,
    Object? landId = freezed,
    Object? farmId = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$HardwareDeviceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        deviceSerial: null == deviceSerial
            ? _value.deviceSerial
            : deviceSerial // ignore: cast_nullable_to_non_nullable
                  as String,
        deviceType: freezed == deviceType
            ? _value.deviceType
            : deviceType // ignore: cast_nullable_to_non_nullable
                  as String?,
        landId: freezed == landId
            ? _value.landId
            : landId // ignore: cast_nullable_to_non_nullable
                  as int?,
        farmId: freezed == farmId
            ? _value.farmId
            : farmId // ignore: cast_nullable_to_non_nullable
                  as int?,
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
class _$HardwareDeviceImpl implements _HardwareDevice {
  const _$HardwareDeviceImpl({
    required this.id,
    @JsonKey(name: 'device_serial') required this.deviceSerial,
    @JsonKey(name: 'device_type') this.deviceType,
    @JsonKey(name: 'land_id') this.landId,
    @JsonKey(name: 'farm_id') this.farmId,
    this.status,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$HardwareDeviceImpl.fromJson(Map<String, dynamic> json) =>
      _$$HardwareDeviceImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'device_serial')
  final String deviceSerial;
  @override
  @JsonKey(name: 'device_type')
  final String? deviceType;
  @override
  @JsonKey(name: 'land_id')
  final int? landId;
  @override
  @JsonKey(name: 'farm_id')
  final int? farmId;
  @override
  final String? status;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @override
  String toString() {
    return 'HardwareDevice(id: $id, deviceSerial: $deviceSerial, deviceType: $deviceType, landId: $landId, farmId: $farmId, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HardwareDeviceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.deviceSerial, deviceSerial) ||
                other.deviceSerial == deviceSerial) &&
            (identical(other.deviceType, deviceType) ||
                other.deviceType == deviceType) &&
            (identical(other.landId, landId) || other.landId == landId) &&
            (identical(other.farmId, farmId) || other.farmId == farmId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    deviceSerial,
    deviceType,
    landId,
    farmId,
    status,
    createdAt,
  );

  /// Create a copy of HardwareDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HardwareDeviceImplCopyWith<_$HardwareDeviceImpl> get copyWith =>
      __$$HardwareDeviceImplCopyWithImpl<_$HardwareDeviceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$HardwareDeviceImplToJson(this);
  }
}

abstract class _HardwareDevice implements HardwareDevice {
  const factory _HardwareDevice({
    required final int id,
    @JsonKey(name: 'device_serial') required final String deviceSerial,
    @JsonKey(name: 'device_type') final String? deviceType,
    @JsonKey(name: 'land_id') final int? landId,
    @JsonKey(name: 'farm_id') final int? farmId,
    final String? status,
    @JsonKey(name: 'created_at') final String? createdAt,
  }) = _$HardwareDeviceImpl;

  factory _HardwareDevice.fromJson(Map<String, dynamic> json) =
      _$HardwareDeviceImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'device_serial')
  String get deviceSerial;
  @override
  @JsonKey(name: 'device_type')
  String? get deviceType;
  @override
  @JsonKey(name: 'land_id')
  int? get landId;
  @override
  @JsonKey(name: 'farm_id')
  int? get farmId;
  @override
  String? get status;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;

  /// Create a copy of HardwareDevice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HardwareDeviceImplCopyWith<_$HardwareDeviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
