import 'dart:io';

abstract class DiagnosticRepository {
  Future<int> scanPlant(
    File imageFile, {
    int? landId,
    int? plantingId,
    String? cropName,
    String? lang,
  });
  Future<Map<String, dynamic>> getDiagnosticLog(int logId);
  Future<List<Map<String, dynamic>>> getDiagnosticLogs();
}
