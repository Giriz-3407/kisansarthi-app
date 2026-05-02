import 'package:kisansarthi/shared/models/soil_reading.dart';

SoilReading? latestValidSoilData(List<SoilReading> readings) {
  for (final reading in readings) {
    if (hasRequiredSoilData(reading)) return reading;
  }
  return null;
}

bool hasRequiredSoilData(SoilReading? soilData) {
  return soilData != null &&
      soilData.nitrogen != null &&
      soilData.phosphorus != null &&
      soilData.potassium != null &&
      soilData.ph != null &&
      soilData.rainfall != null &&
      soilData.temperature != null &&
      soilData.humidity != null;
}
