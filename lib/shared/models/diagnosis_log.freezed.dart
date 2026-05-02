// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagnosis_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DiagnosisLog _$DiagnosisLogFromJson(Map<String, dynamic> json) {
  return _DiagnosisLog.fromJson(json);
}

/// @nodoc
mixin _$DiagnosisLog {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'land_id')
  int? get landId => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_path')
  String? get imagePath => throw _privateConstructorUsedError;
  @JsonKey(name: 'disease_name')
  String? get diseaseName => throw _privateConstructorUsedError;
  double? get confidence => throw _privateConstructorUsedError;
  String? get symptoms => throw _privateConstructorUsedError;
  List<String>? get remedies => throw _privateConstructorUsedError;
  String? get prevention => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this DiagnosisLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiagnosisLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiagnosisLogCopyWith<DiagnosisLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiagnosisLogCopyWith<$Res> {
  factory $DiagnosisLogCopyWith(
    DiagnosisLog value,
    $Res Function(DiagnosisLog) then,
  ) = _$DiagnosisLogCopyWithImpl<$Res, DiagnosisLog>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'user_id') int userId,
    @JsonKey(name: 'land_id') int? landId,
    @JsonKey(name: 'image_path') String? imagePath,
    @JsonKey(name: 'disease_name') String? diseaseName,
    double? confidence,
    String? symptoms,
    List<String>? remedies,
    String? prevention,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class _$DiagnosisLogCopyWithImpl<$Res, $Val extends DiagnosisLog>
    implements $DiagnosisLogCopyWith<$Res> {
  _$DiagnosisLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiagnosisLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? landId = freezed,
    Object? imagePath = freezed,
    Object? diseaseName = freezed,
    Object? confidence = freezed,
    Object? symptoms = freezed,
    Object? remedies = freezed,
    Object? prevention = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            landId: freezed == landId
                ? _value.landId
                : landId // ignore: cast_nullable_to_non_nullable
                      as int?,
            imagePath: freezed == imagePath
                ? _value.imagePath
                : imagePath // ignore: cast_nullable_to_non_nullable
                      as String?,
            diseaseName: freezed == diseaseName
                ? _value.diseaseName
                : diseaseName // ignore: cast_nullable_to_non_nullable
                      as String?,
            confidence: freezed == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double?,
            symptoms: freezed == symptoms
                ? _value.symptoms
                : symptoms // ignore: cast_nullable_to_non_nullable
                      as String?,
            remedies: freezed == remedies
                ? _value.remedies
                : remedies // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            prevention: freezed == prevention
                ? _value.prevention
                : prevention // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$DiagnosisLogImplCopyWith<$Res>
    implements $DiagnosisLogCopyWith<$Res> {
  factory _$$DiagnosisLogImplCopyWith(
    _$DiagnosisLogImpl value,
    $Res Function(_$DiagnosisLogImpl) then,
  ) = __$$DiagnosisLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'user_id') int userId,
    @JsonKey(name: 'land_id') int? landId,
    @JsonKey(name: 'image_path') String? imagePath,
    @JsonKey(name: 'disease_name') String? diseaseName,
    double? confidence,
    String? symptoms,
    List<String>? remedies,
    String? prevention,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
  });
}

/// @nodoc
class __$$DiagnosisLogImplCopyWithImpl<$Res>
    extends _$DiagnosisLogCopyWithImpl<$Res, _$DiagnosisLogImpl>
    implements _$$DiagnosisLogImplCopyWith<$Res> {
  __$$DiagnosisLogImplCopyWithImpl(
    _$DiagnosisLogImpl _value,
    $Res Function(_$DiagnosisLogImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiagnosisLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? landId = freezed,
    Object? imagePath = freezed,
    Object? diseaseName = freezed,
    Object? confidence = freezed,
    Object? symptoms = freezed,
    Object? remedies = freezed,
    Object? prevention = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$DiagnosisLogImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        landId: freezed == landId
            ? _value.landId
            : landId // ignore: cast_nullable_to_non_nullable
                  as int?,
        imagePath: freezed == imagePath
            ? _value.imagePath
            : imagePath // ignore: cast_nullable_to_non_nullable
                  as String?,
        diseaseName: freezed == diseaseName
            ? _value.diseaseName
            : diseaseName // ignore: cast_nullable_to_non_nullable
                  as String?,
        confidence: freezed == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double?,
        symptoms: freezed == symptoms
            ? _value.symptoms
            : symptoms // ignore: cast_nullable_to_non_nullable
                  as String?,
        remedies: freezed == remedies
            ? _value._remedies
            : remedies // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        prevention: freezed == prevention
            ? _value.prevention
            : prevention // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$DiagnosisLogImpl implements _DiagnosisLog {
  const _$DiagnosisLogImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'land_id') this.landId,
    @JsonKey(name: 'image_path') this.imagePath,
    @JsonKey(name: 'disease_name') this.diseaseName,
    this.confidence,
    this.symptoms,
    final List<String>? remedies,
    this.prevention,
    this.status,
    @JsonKey(name: 'created_at') this.createdAt,
  }) : _remedies = remedies;

  factory _$DiagnosisLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiagnosisLogImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey(name: 'land_id')
  final int? landId;
  @override
  @JsonKey(name: 'image_path')
  final String? imagePath;
  @override
  @JsonKey(name: 'disease_name')
  final String? diseaseName;
  @override
  final double? confidence;
  @override
  final String? symptoms;
  final List<String>? _remedies;
  @override
  List<String>? get remedies {
    final value = _remedies;
    if (value == null) return null;
    if (_remedies is EqualUnmodifiableListView) return _remedies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? prevention;
  @override
  final String? status;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @override
  String toString() {
    return 'DiagnosisLog(id: $id, userId: $userId, landId: $landId, imagePath: $imagePath, diseaseName: $diseaseName, confidence: $confidence, symptoms: $symptoms, remedies: $remedies, prevention: $prevention, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiagnosisLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.landId, landId) || other.landId == landId) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.diseaseName, diseaseName) ||
                other.diseaseName == diseaseName) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.symptoms, symptoms) ||
                other.symptoms == symptoms) &&
            const DeepCollectionEquality().equals(other._remedies, _remedies) &&
            (identical(other.prevention, prevention) ||
                other.prevention == prevention) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    landId,
    imagePath,
    diseaseName,
    confidence,
    symptoms,
    const DeepCollectionEquality().hash(_remedies),
    prevention,
    status,
    createdAt,
  );

  /// Create a copy of DiagnosisLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiagnosisLogImplCopyWith<_$DiagnosisLogImpl> get copyWith =>
      __$$DiagnosisLogImplCopyWithImpl<_$DiagnosisLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiagnosisLogImplToJson(this);
  }
}

abstract class _DiagnosisLog implements DiagnosisLog {
  const factory _DiagnosisLog({
    required final int id,
    @JsonKey(name: 'user_id') required final int userId,
    @JsonKey(name: 'land_id') final int? landId,
    @JsonKey(name: 'image_path') final String? imagePath,
    @JsonKey(name: 'disease_name') final String? diseaseName,
    final double? confidence,
    final String? symptoms,
    final List<String>? remedies,
    final String? prevention,
    final String? status,
    @JsonKey(name: 'created_at') final String? createdAt,
  }) = _$DiagnosisLogImpl;

  factory _DiagnosisLog.fromJson(Map<String, dynamic> json) =
      _$DiagnosisLogImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  @JsonKey(name: 'land_id')
  int? get landId;
  @override
  @JsonKey(name: 'image_path')
  String? get imagePath;
  @override
  @JsonKey(name: 'disease_name')
  String? get diseaseName;
  @override
  double? get confidence;
  @override
  String? get symptoms;
  @override
  List<String>? get remedies;
  @override
  String? get prevention;
  @override
  String? get status;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;

  /// Create a copy of DiagnosisLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiagnosisLogImplCopyWith<_$DiagnosisLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
