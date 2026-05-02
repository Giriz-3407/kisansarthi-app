import 'package:dio/dio.dart';
import 'package:kisansarthi/core/network/api_utils.dart';
import 'package:kisansarthi/features/devices/domain/device_repository.dart';
import 'package:kisansarthi/shared/models/hardware_device.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  final Dio _dio;

  DeviceRepositoryImpl(this._dio);

  Map<String, dynamic> _toDeviceJson(Map<String, dynamic> raw) {
    return {
      ...raw,
      'device_serial': raw['hardware_unique_id'] ?? '',
      'device_type': raw['model'],
      'land_id': raw['assigned_land_id'],
    };
  }

  @override
  Future<List<HardwareDevice>> getDevicesByFarm(int farmId) async {
    final response = await _dio.get('/farms/$farmId/hardware_devices');
    final list = ApiUtils.extractWrappedList(response.data, keys: ['devices']);
    return list
        .whereType<Map<String, dynamic>>()
        .map((e) => HardwareDevice.fromJson(_toDeviceJson(e)))
        .toList();
  }

  @override
  Future<HardwareDevice> getDeviceById(int id) async {
    final response = await _dio.get('/hardware_devices/$id');
    final map = ApiUtils.extractMap(response.data);
    return HardwareDevice.fromJson(_toDeviceJson(map));
  }

  @override
  Future<HardwareDevice> createDevice(int farmId, String deviceSerial, {String? deviceType}) async {
    final payload = <String, dynamic>{
      'hardware_unique_id': deviceSerial,
      'farm_id': farmId,
      if (deviceType != null && deviceType.isNotEmpty) 'model': deviceType,
    };
    final response = await _dio.post('/hardware_devices', data: payload);
    final map = ApiUtils.extractMap(response.data);
    return HardwareDevice.fromJson(_toDeviceJson(map));
  }

  @override
  Future<HardwareDevice> assignDevice(int deviceId, {int? farmId, int? landId}) async {
    final response = await _dio.put('/hardware_devices/$deviceId/assignment', data: {
      'assigned_land_id': landId,
    });
    final map = ApiUtils.extractMap(response.data);
    return HardwareDevice.fromJson(_toDeviceJson(map));
  }

  @override
  Future<void> deleteDevice(int id) async {
    await _dio.delete('/hardware_devices/$id');
  }
}
