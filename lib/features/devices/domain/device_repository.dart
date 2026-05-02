import 'package:kisansarthi/shared/models/hardware_device.dart';

abstract class DeviceRepository {
  Future<List<HardwareDevice>> getDevicesByFarm(int farmId);
  Future<HardwareDevice> getDeviceById(int id);
  Future<HardwareDevice> createDevice(int farmId, String deviceSerial, {String? deviceType});
  Future<HardwareDevice> assignDevice(int deviceId, {int? farmId, int? landId});
  Future<void> deleteDevice(int id);
}
