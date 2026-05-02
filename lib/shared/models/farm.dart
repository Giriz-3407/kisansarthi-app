import 'package:freezed_annotation/freezed_annotation.dart';

part 'farm.freezed.dart';
part 'farm.g.dart';

@freezed
class Farm with _$Farm {
  const factory Farm({
    required int id,
    required String name,
    String? location,
    String? address,
    @JsonKey(name: 'image_path') String? imagePath,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _Farm;

  factory Farm.fromJson(Map<String, dynamic> json) => _$FarmFromJson(json);
}
