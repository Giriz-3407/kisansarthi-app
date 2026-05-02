import 'package:freezed_annotation/freezed_annotation.dart';

part 'diagnosis_log.freezed.dart';
part 'diagnosis_log.g.dart';

@freezed
class DiagnosisLog with _$DiagnosisLog {
  const factory DiagnosisLog({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'land_id') int? landId,
    @JsonKey(name: 'image_path') String? imagePath,
    @JsonKey(name: 'disease_name') String? diseaseName,
    double? confidence,
    String? symptoms,
    List<String>? remedies,
    String? prevention,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _DiagnosisLog;

  factory DiagnosisLog.fromJson(Map<String, dynamic> json) => _$DiagnosisLogFromJson(json);
}
