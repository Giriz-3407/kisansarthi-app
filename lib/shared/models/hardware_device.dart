import 'package:freezed_annotation/freezed_annotation.dart';

part 'hardware_device.freezed.dart';
part 'hardware_device.g.dart';

@freezed
class HardwareDevice with _$HardwareDevice {
  const factory HardwareDevice({
    required int id,
    @JsonKey(name: 'device_serial') required String deviceSerial,
    @JsonKey(name: 'device_type') String? deviceType,
    @JsonKey(name: 'land_id') int? landId,
    @JsonKey(name: 'farm_id') int? farmId,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _HardwareDevice;

  factory HardwareDevice.fromJson(Map<String, dynamic> json) => _$HardwareDeviceFromJson(json);
}
