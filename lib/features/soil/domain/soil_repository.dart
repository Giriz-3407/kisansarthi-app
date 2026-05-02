import 'package:kisansarthi/shared/models/soil_reading.dart';

abstract class SoilRepository {
  Future<List<SoilReading>> getSoilReadings(int landId, {int? limit, int? offset});
  Future<void> addManualSoilReading(int landId, Map<String, dynamic> data);
}
