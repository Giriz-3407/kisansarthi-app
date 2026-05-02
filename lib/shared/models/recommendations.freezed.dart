// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recommendations.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CropItem _$CropItemFromJson(Map<String, dynamic> json) {
  return _CropItem.fromJson(json);
}

/// @nodoc
mixin _$CropItem {
  String get crop => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  @JsonKey(includeFromJson: false, includeToJson: false)
  $CropItemCopyWith<CropItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CropItemCopyWith<$Res> {
  factory $CropItemCopyWith(CropItem value, $Res Function(CropItem) then) =
      _$CropItemCopyWithImpl<$Res, CropItem>;
  @useResult
  $Res call({String crop, double confidence});
}

/// @nodoc
class _$CropItemCopyWithImpl<$Res, $Val extends CropItem>
    implements $CropItemCopyWith<$Res> {
  _$CropItemCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? crop = null, Object? confidence = null}) {
    return _then(
      _value.copyWith(
            crop: null == crop ? _value.crop : crop as String,
            confidence: null == confidence
                ? _value.confidence
                : confidence as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CropItemImplCopyWith<$Res>
    implements $CropItemCopyWith<$Res> {
  factory _$$CropItemImplCopyWith(
    _$CropItemImpl value,
    $Res Function(_$CropItemImpl) then,
  ) = __$$CropItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String crop, double confidence});
}

/// @nodoc
class __$$CropItemImplCopyWithImpl<$Res>
    extends _$CropItemCopyWithImpl<$Res, _$CropItemImpl>
    implements _$$CropItemImplCopyWith<$Res> {
  __$$CropItemImplCopyWithImpl(
    _$CropItemImpl _value,
    $Res Function(_$CropItemImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? crop = null, Object? confidence = null}) {
    return _then(
      _$CropItemImpl(
        crop: null == crop ? _value.crop : crop as String,
        confidence: null == confidence ? _value.confidence : confidence as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CropItemImpl implements _CropItem {
  const _$CropItemImpl({required this.crop, required this.confidence});

  factory _$CropItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CropItemImplFromJson(json);

  @override
  final String crop;
  @override
  final double confidence;

  @override
  String toString() {
    return 'CropItem(crop: $crop, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CropItemImpl &&
            other.crop == crop &&
            other.confidence == confidence);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, crop, confidence);

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  _$$CropItemImplCopyWith<_$CropItemImpl> get copyWith =>
      __$$CropItemImplCopyWithImpl<_$CropItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CropItemImplToJson(this);
  }
}

abstract class _CropItem implements CropItem {
  const factory _CropItem({
    required final String crop,
    required final double confidence,
  }) = _$CropItemImpl;

  factory _CropItem.fromJson(Map<String, dynamic> json) =
      _$CropItemImpl.fromJson;

  @override
  String get crop;
  @override
  double get confidence;
  @override
  _$$CropItemImplCopyWith<_$CropItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CropSuggestion _$CropSuggestionFromJson(Map<String, dynamic> json) {
  return _CropSuggestion.fromJson(json);
}

/// @nodoc
mixin _$CropSuggestion {
  @JsonKey(name: 'crop_name')
  String get cropName => throw _privateConstructorUsedError;
  double get match => throw _privateConstructorUsedError;
  @JsonKey(name: 'top_crops')
  List<CropItem> get topCrops => throw _privateConstructorUsedError;
  @JsonKey(name: 'primary_crop')
  CropItem get primaryCrop => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  String? get explanation => throw _privateConstructorUsedError;
  @JsonKey(name: 'expected_yield')
  String? get expectedYield => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  @JsonKey(includeFromJson: false, includeToJson: false)
  $CropSuggestionCopyWith<CropSuggestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CropSuggestionCopyWith<$Res> {
  factory $CropSuggestionCopyWith(
    CropSuggestion value,
    $Res Function(CropSuggestion) then,
  ) = _$CropSuggestionCopyWithImpl<$Res, CropSuggestion>;
  @useResult
  $Res call({
    @JsonKey(name: 'crop_name') String cropName,
    double match,
    @JsonKey(name: 'top_crops') List<CropItem> topCrops,
    @JsonKey(name: 'primary_crop') CropItem primaryCrop,
    String? reason,
    String? explanation,
    @JsonKey(name: 'expected_yield') String? expectedYield,
  });
}

/// @nodoc
class _$CropSuggestionCopyWithImpl<$Res, $Val extends CropSuggestion>
    implements $CropSuggestionCopyWith<$Res> {
  _$CropSuggestionCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cropName = null,
    Object? match = null,
    Object? topCrops = null,
    Object? primaryCrop = null,
    Object? reason = freezed,
    Object? explanation = freezed,
    Object? expectedYield = freezed,
  }) {
    return _then(
      _value.copyWith(
            cropName: null == cropName ? _value.cropName : cropName as String,
            match: null == match ? _value.match : match as double,
            topCrops: null == topCrops
                ? _value.topCrops
                : topCrops as List<CropItem>,
            primaryCrop: null == primaryCrop
                ? _value.primaryCrop
                : primaryCrop as CropItem,
            reason: freezed == reason ? _value.reason : reason as String?,
            explanation: freezed == explanation
                ? _value.explanation
                : explanation as String?,
            expectedYield: freezed == expectedYield
                ? _value.expectedYield
                : expectedYield as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CropSuggestionImplCopyWith<$Res>
    implements $CropSuggestionCopyWith<$Res> {
  factory _$$CropSuggestionImplCopyWith(
    _$CropSuggestionImpl value,
    $Res Function(_$CropSuggestionImpl) then,
  ) = __$$CropSuggestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'crop_name') String cropName,
    double match,
    @JsonKey(name: 'top_crops') List<CropItem> topCrops,
    @JsonKey(name: 'primary_crop') CropItem primaryCrop,
    String? reason,
    String? explanation,
    @JsonKey(name: 'expected_yield') String? expectedYield,
  });
}

/// @nodoc
class __$$CropSuggestionImplCopyWithImpl<$Res>
    extends _$CropSuggestionCopyWithImpl<$Res, _$CropSuggestionImpl>
    implements _$$CropSuggestionImplCopyWith<$Res> {
  __$$CropSuggestionImplCopyWithImpl(
    _$CropSuggestionImpl _value,
    $Res Function(_$CropSuggestionImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cropName = null,
    Object? match = null,
    Object? topCrops = null,
    Object? primaryCrop = null,
    Object? reason = freezed,
    Object? explanation = freezed,
    Object? expectedYield = freezed,
  }) {
    return _then(
      _$CropSuggestionImpl(
        cropName: null == cropName ? _value.cropName : cropName as String,
        match: null == match ? _value.match : match as double,
        topCrops: null == topCrops
            ? _value.topCrops
            : topCrops as List<CropItem>,
        primaryCrop: null == primaryCrop
            ? _value.primaryCrop
            : primaryCrop as CropItem,
        reason: freezed == reason ? _value.reason : reason as String?,
        explanation: freezed == explanation
            ? _value.explanation
            : explanation as String?,
        expectedYield: freezed == expectedYield
            ? _value.expectedYield
            : expectedYield as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CropSuggestionImpl implements _CropSuggestion {
  const _$CropSuggestionImpl({
    @JsonKey(name: 'crop_name') required this.cropName,
    required this.match,
    @JsonKey(name: 'top_crops') final List<CropItem> topCrops = const <CropItem>[],
    @JsonKey(name: 'primary_crop') required this.primaryCrop,
    this.reason,
    this.explanation,
    @JsonKey(name: 'expected_yield') this.expectedYield,
  }) : _topCrops = topCrops;

  factory _$CropSuggestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$CropSuggestionImplFromJson(json);

  @override
  @JsonKey(name: 'crop_name')
  final String cropName;
  @override
  final double match;
  final List<CropItem> _topCrops;
  @override
  @JsonKey(name: 'top_crops')
  List<CropItem> get topCrops => _topCrops;
  @override
  @JsonKey(name: 'primary_crop')
  final CropItem primaryCrop;
  @override
  final String? reason;
  @override
  final String? explanation;
  @override
  @JsonKey(name: 'expected_yield')
  final String? expectedYield;

  @override
  String toString() {
    return 'CropSuggestion(cropName: $cropName, match: $match, topCrops: $topCrops, primaryCrop: $primaryCrop, reason: $reason, explanation: $explanation, expectedYield: $expectedYield)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CropSuggestionImpl &&
            other.cropName == cropName &&
            other.match == match &&
            other.topCrops.length == topCrops.length &&
            Object.hashAll(other.topCrops) == Object.hashAll(topCrops) &&
            other.primaryCrop == primaryCrop &&
            other.reason == reason &&
            other.explanation == explanation &&
            other.expectedYield == expectedYield);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    cropName,
    match,
    Object.hashAll(topCrops),
    primaryCrop,
    reason,
    explanation,
    expectedYield,
  );

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  _$$CropSuggestionImplCopyWith<_$CropSuggestionImpl> get copyWith =>
      __$$CropSuggestionImplCopyWithImpl<_$CropSuggestionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CropSuggestionImplToJson(this);
  }
}

abstract class _CropSuggestion implements CropSuggestion {
  const factory _CropSuggestion({
    @JsonKey(name: 'crop_name') required final String cropName,
    required final double match,
    @JsonKey(name: 'top_crops') final List<CropItem> topCrops,
    @JsonKey(name: 'primary_crop') required final CropItem primaryCrop,
    final String? reason,
    final String? explanation,
    @JsonKey(name: 'expected_yield') final String? expectedYield,
  }) = _$CropSuggestionImpl;

  factory _CropSuggestion.fromJson(Map<String, dynamic> json) =
      _$CropSuggestionImpl.fromJson;

  @override
  @JsonKey(name: 'crop_name')
  String get cropName;
  @override
  double get match;
  @override
  @JsonKey(name: 'top_crops')
  List<CropItem> get topCrops;
  @override
  @JsonKey(name: 'primary_crop')
  CropItem get primaryCrop;
  @override
  String? get reason;
  @override
  String? get explanation;
  @override
  @JsonKey(name: 'expected_yield')
  String? get expectedYield;
  @override
  _$$CropSuggestionImplCopyWith<_$CropSuggestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FertilizerRecommendation _$FertilizerRecommendationFromJson(
  Map<String, dynamic> json,
) {
  return _FertilizerRecommendation.fromJson(json);
}

/// @nodoc
mixin _$FertilizerRecommendation {
  @JsonKey(name: 'fertilizer_name')
  String get fertilizerName => throw _privateConstructorUsedError;
  String get dosage => throw _privateConstructorUsedError;
  String? get explanation => throw _privateConstructorUsedError;
  String? get advisory => throw _privateConstructorUsedError;
  @JsonKey(name: 'buy_at')
  String? get buyAt => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;

  /// Serializes this FertilizerRecommendation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FertilizerRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FertilizerRecommendationCopyWith<FertilizerRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FertilizerRecommendationCopyWith<$Res> {
  factory $FertilizerRecommendationCopyWith(
    FertilizerRecommendation value,
    $Res Function(FertilizerRecommendation) then,
  ) = _$FertilizerRecommendationCopyWithImpl<$Res, FertilizerRecommendation>;
  @useResult
  $Res call({
    @JsonKey(name: 'fertilizer_name') String fertilizerName,
    String dosage,
    String? explanation,
    String? advisory,
    @JsonKey(name: 'buy_at') String? buyAt,
    double? price,
  });
}

/// @nodoc
class _$FertilizerRecommendationCopyWithImpl<
  $Res,
  $Val extends FertilizerRecommendation
>
    implements $FertilizerRecommendationCopyWith<$Res> {
  _$FertilizerRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FertilizerRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fertilizerName = null,
    Object? dosage = null,
    Object? explanation = freezed,
    Object? advisory = freezed,
    Object? buyAt = freezed,
    Object? price = freezed,
  }) {
    return _then(
      _value.copyWith(
            fertilizerName: null == fertilizerName
                ? _value.fertilizerName
                : fertilizerName // ignore: cast_nullable_to_non_nullable
                      as String,
            dosage: null == dosage
                ? _value.dosage
                : dosage // ignore: cast_nullable_to_non_nullable
                      as String,
            explanation: freezed == explanation
                ? _value.explanation
                : explanation // ignore: cast_nullable_to_non_nullable
                      as String?,
            advisory: freezed == advisory
                ? _value.advisory
                : advisory // ignore: cast_nullable_to_non_nullable
                      as String?,
            buyAt: freezed == buyAt
                ? _value.buyAt
                : buyAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            price: freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FertilizerRecommendationImplCopyWith<$Res>
    implements $FertilizerRecommendationCopyWith<$Res> {
  factory _$$FertilizerRecommendationImplCopyWith(
    _$FertilizerRecommendationImpl value,
    $Res Function(_$FertilizerRecommendationImpl) then,
  ) = __$$FertilizerRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'fertilizer_name') String fertilizerName,
    String dosage,
    String? explanation,
    String? advisory,
    @JsonKey(name: 'buy_at') String? buyAt,
    double? price,
  });
}

/// @nodoc
class __$$FertilizerRecommendationImplCopyWithImpl<$Res>
    extends
        _$FertilizerRecommendationCopyWithImpl<
          $Res,
          _$FertilizerRecommendationImpl
        >
    implements _$$FertilizerRecommendationImplCopyWith<$Res> {
  __$$FertilizerRecommendationImplCopyWithImpl(
    _$FertilizerRecommendationImpl _value,
    $Res Function(_$FertilizerRecommendationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FertilizerRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fertilizerName = null,
    Object? dosage = null,
    Object? explanation = freezed,
    Object? advisory = freezed,
    Object? buyAt = freezed,
    Object? price = freezed,
  }) {
    return _then(
      _$FertilizerRecommendationImpl(
        fertilizerName: null == fertilizerName
            ? _value.fertilizerName
            : fertilizerName // ignore: cast_nullable_to_non_nullable
                  as String,
        dosage: null == dosage
            ? _value.dosage
            : dosage // ignore: cast_nullable_to_non_nullable
                  as String,
        explanation: freezed == explanation
            ? _value.explanation
            : explanation // ignore: cast_nullable_to_non_nullable
                  as String?,
        advisory: freezed == advisory
            ? _value.advisory
            : advisory // ignore: cast_nullable_to_non_nullable
                  as String?,
        buyAt: freezed == buyAt
            ? _value.buyAt
            : buyAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        price: freezed == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FertilizerRecommendationImpl implements _FertilizerRecommendation {
  const _$FertilizerRecommendationImpl({
    @JsonKey(name: 'fertilizer_name') required this.fertilizerName,
    required this.dosage,
    this.explanation,
    this.advisory,
    @JsonKey(name: 'buy_at') this.buyAt,
    this.price,
  });

  factory _$FertilizerRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$FertilizerRecommendationImplFromJson(json);

  @override
  @JsonKey(name: 'fertilizer_name')
  final String fertilizerName;
  @override
  final String dosage;
  @override
  final String? explanation;
  @override
  final String? advisory;
  @override
  @JsonKey(name: 'buy_at')
  final String? buyAt;
  @override
  final double? price;

  @override
  String toString() {
    return 'FertilizerRecommendation(fertilizerName: $fertilizerName, dosage: $dosage, explanation: $explanation, advisory: $advisory, buyAt: $buyAt, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FertilizerRecommendationImpl &&
            (identical(other.fertilizerName, fertilizerName) ||
                other.fertilizerName == fertilizerName) &&
            (identical(other.dosage, dosage) || other.dosage == dosage) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.advisory, advisory) ||
                other.advisory == advisory) &&
            (identical(other.buyAt, buyAt) || other.buyAt == buyAt) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    fertilizerName,
    dosage,
    explanation,
    advisory,
    buyAt,
    price,
  );

  /// Create a copy of FertilizerRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FertilizerRecommendationImplCopyWith<_$FertilizerRecommendationImpl>
  get copyWith =>
      __$$FertilizerRecommendationImplCopyWithImpl<
        _$FertilizerRecommendationImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FertilizerRecommendationImplToJson(this);
  }
}

abstract class _FertilizerRecommendation implements FertilizerRecommendation {
  const factory _FertilizerRecommendation({
    @JsonKey(name: 'fertilizer_name') required final String fertilizerName,
    required final String dosage,
    final String? explanation,
    final String? advisory,
    @JsonKey(name: 'buy_at') final String? buyAt,
    final double? price,
  }) = _$FertilizerRecommendationImpl;

  factory _FertilizerRecommendation.fromJson(Map<String, dynamic> json) =
      _$FertilizerRecommendationImpl.fromJson;

  @override
  @JsonKey(name: 'fertilizer_name')
  String get fertilizerName;
  @override
  String get dosage;
  @override
  String? get explanation;
  @override
  String? get advisory;
  @override
  @JsonKey(name: 'buy_at')
  String? get buyAt;
  @override
  double? get price;

  /// Create a copy of FertilizerRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FertilizerRecommendationImplCopyWith<_$FertilizerRecommendationImpl>
  get copyWith => throw _privateConstructorUsedError;
}
