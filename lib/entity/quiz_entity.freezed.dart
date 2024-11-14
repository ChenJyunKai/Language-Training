// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QuizEntity _$QuizEntityFromJson(Map<String, dynamic> json) {
  return _QuizEntity.fromJson(json);
}

/// @nodoc
mixin _$QuizEntity {
  List<WordEntity> get words => throw _privateConstructorUsedError;
  String get languageId => throw _privateConstructorUsedError;
  dynamic get count => throw _privateConstructorUsedError;
  int? get totalScore => throw _privateConstructorUsedError;
  int? get exp => throw _privateConstructorUsedError;

  /// Serializes this QuizEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizEntityCopyWith<QuizEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizEntityCopyWith<$Res> {
  factory $QuizEntityCopyWith(
          QuizEntity value, $Res Function(QuizEntity) then) =
      _$QuizEntityCopyWithImpl<$Res, QuizEntity>;
  @useResult
  $Res call(
      {List<WordEntity> words,
      String languageId,
      dynamic count,
      int? totalScore,
      int? exp});
}

/// @nodoc
class _$QuizEntityCopyWithImpl<$Res, $Val extends QuizEntity>
    implements $QuizEntityCopyWith<$Res> {
  _$QuizEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? words = null,
    Object? languageId = null,
    Object? count = freezed,
    Object? totalScore = freezed,
    Object? exp = freezed,
  }) {
    return _then(_value.copyWith(
      words: null == words
          ? _value.words
          : words // ignore: cast_nullable_to_non_nullable
              as List<WordEntity>,
      languageId: null == languageId
          ? _value.languageId
          : languageId // ignore: cast_nullable_to_non_nullable
              as String,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as dynamic,
      totalScore: freezed == totalScore
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as int?,
      exp: freezed == exp
          ? _value.exp
          : exp // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuizEntityImplCopyWith<$Res>
    implements $QuizEntityCopyWith<$Res> {
  factory _$$QuizEntityImplCopyWith(
          _$QuizEntityImpl value, $Res Function(_$QuizEntityImpl) then) =
      __$$QuizEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<WordEntity> words,
      String languageId,
      dynamic count,
      int? totalScore,
      int? exp});
}

/// @nodoc
class __$$QuizEntityImplCopyWithImpl<$Res>
    extends _$QuizEntityCopyWithImpl<$Res, _$QuizEntityImpl>
    implements _$$QuizEntityImplCopyWith<$Res> {
  __$$QuizEntityImplCopyWithImpl(
      _$QuizEntityImpl _value, $Res Function(_$QuizEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuizEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? words = null,
    Object? languageId = null,
    Object? count = freezed,
    Object? totalScore = freezed,
    Object? exp = freezed,
  }) {
    return _then(_$QuizEntityImpl(
      words: null == words
          ? _value._words
          : words // ignore: cast_nullable_to_non_nullable
              as List<WordEntity>,
      languageId: null == languageId
          ? _value.languageId
          : languageId // ignore: cast_nullable_to_non_nullable
              as String,
      count: freezed == count ? _value.count! : count,
      totalScore: freezed == totalScore
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as int?,
      exp: freezed == exp
          ? _value.exp
          : exp // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizEntityImpl implements _QuizEntity {
  const _$QuizEntityImpl(
      {final List<WordEntity> words = const [],
      this.languageId = '',
      this.count = 0,
      this.totalScore,
      this.exp})
      : _words = words;

  factory _$QuizEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizEntityImplFromJson(json);

  final List<WordEntity> _words;
  @override
  @JsonKey()
  List<WordEntity> get words {
    if (_words is EqualUnmodifiableListView) return _words;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_words);
  }

  @override
  @JsonKey()
  final String languageId;
  @override
  @JsonKey()
  final dynamic count;
  @override
  final int? totalScore;
  @override
  final int? exp;

  @override
  String toString() {
    return 'QuizEntity(words: $words, languageId: $languageId, count: $count, totalScore: $totalScore, exp: $exp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizEntityImpl &&
            const DeepCollectionEquality().equals(other._words, _words) &&
            (identical(other.languageId, languageId) ||
                other.languageId == languageId) &&
            const DeepCollectionEquality().equals(other.count, count) &&
            (identical(other.totalScore, totalScore) ||
                other.totalScore == totalScore) &&
            (identical(other.exp, exp) || other.exp == exp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_words),
      languageId,
      const DeepCollectionEquality().hash(count),
      totalScore,
      exp);

  /// Create a copy of QuizEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizEntityImplCopyWith<_$QuizEntityImpl> get copyWith =>
      __$$QuizEntityImplCopyWithImpl<_$QuizEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizEntityImplToJson(
      this,
    );
  }
}

abstract class _QuizEntity implements QuizEntity {
  const factory _QuizEntity(
      {final List<WordEntity> words,
      final String languageId,
      final dynamic count,
      final int? totalScore,
      final int? exp}) = _$QuizEntityImpl;

  factory _QuizEntity.fromJson(Map<String, dynamic> json) =
      _$QuizEntityImpl.fromJson;

  @override
  List<WordEntity> get words;
  @override
  String get languageId;
  @override
  dynamic get count;
  @override
  int? get totalScore;
  @override
  int? get exp;

  /// Create a copy of QuizEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizEntityImplCopyWith<_$QuizEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WordEntity _$WordEntityFromJson(Map<String, dynamic> json) {
  return _WordEntity.fromJson(json);
}

/// @nodoc
mixin _$WordEntity {
  String get word => throw _privateConstructorUsedError;
  String get hint => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;

  /// Serializes this WordEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WordEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WordEntityCopyWith<WordEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WordEntityCopyWith<$Res> {
  factory $WordEntityCopyWith(
          WordEntity value, $Res Function(WordEntity) then) =
      _$WordEntityCopyWithImpl<$Res, WordEntity>;
  @useResult
  $Res call({String word, String hint, int score});
}

/// @nodoc
class _$WordEntityCopyWithImpl<$Res, $Val extends WordEntity>
    implements $WordEntityCopyWith<$Res> {
  _$WordEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WordEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? word = null,
    Object? hint = null,
    Object? score = null,
  }) {
    return _then(_value.copyWith(
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      hint: null == hint
          ? _value.hint
          : hint // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WordEntityImplCopyWith<$Res>
    implements $WordEntityCopyWith<$Res> {
  factory _$$WordEntityImplCopyWith(
          _$WordEntityImpl value, $Res Function(_$WordEntityImpl) then) =
      __$$WordEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String word, String hint, int score});
}

/// @nodoc
class __$$WordEntityImplCopyWithImpl<$Res>
    extends _$WordEntityCopyWithImpl<$Res, _$WordEntityImpl>
    implements _$$WordEntityImplCopyWith<$Res> {
  __$$WordEntityImplCopyWithImpl(
      _$WordEntityImpl _value, $Res Function(_$WordEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of WordEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? word = null,
    Object? hint = null,
    Object? score = null,
  }) {
    return _then(_$WordEntityImpl(
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      hint: null == hint
          ? _value.hint
          : hint // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WordEntityImpl implements _WordEntity {
  const _$WordEntityImpl(
      {required this.word, required this.hint, this.score = 0});

  factory _$WordEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$WordEntityImplFromJson(json);

  @override
  final String word;
  @override
  final String hint;
  @override
  @JsonKey()
  final int score;

  @override
  String toString() {
    return 'WordEntity(word: $word, hint: $hint, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WordEntityImpl &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.hint, hint) || other.hint == hint) &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, word, hint, score);

  /// Create a copy of WordEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WordEntityImplCopyWith<_$WordEntityImpl> get copyWith =>
      __$$WordEntityImplCopyWithImpl<_$WordEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WordEntityImplToJson(
      this,
    );
  }
}

abstract class _WordEntity implements WordEntity {
  const factory _WordEntity(
      {required final String word,
      required final String hint,
      final int score}) = _$WordEntityImpl;

  factory _WordEntity.fromJson(Map<String, dynamic> json) =
      _$WordEntityImpl.fromJson;

  @override
  String get word;
  @override
  String get hint;
  @override
  int get score;

  /// Create a copy of WordEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WordEntityImplCopyWith<_$WordEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
