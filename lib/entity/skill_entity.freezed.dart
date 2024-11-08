// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skill_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SkillEntity _$SkillEntityFromJson(Map<String, dynamic> json) {
  return _SkillEntity.fromJson(json);
}

/// @nodoc
mixin _$SkillEntity {
  String get skillCode => throw _privateConstructorUsedError;
  String get skillName => throw _privateConstructorUsedError;
  String get skillDescription => throw _privateConstructorUsedError;
  int get levelRestriction => throw _privateConstructorUsedError;
  int get coolDown => throw _privateConstructorUsedError;
  SkillType get skillType => throw _privateConstructorUsedError;
  dynamic get level => throw _privateConstructorUsedError;

  /// Serializes this SkillEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SkillEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SkillEntityCopyWith<SkillEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkillEntityCopyWith<$Res> {
  factory $SkillEntityCopyWith(
          SkillEntity value, $Res Function(SkillEntity) then) =
      _$SkillEntityCopyWithImpl<$Res, SkillEntity>;
  @useResult
  $Res call(
      {String skillCode,
      String skillName,
      String skillDescription,
      int levelRestriction,
      int coolDown,
      SkillType skillType,
      dynamic level});
}

/// @nodoc
class _$SkillEntityCopyWithImpl<$Res, $Val extends SkillEntity>
    implements $SkillEntityCopyWith<$Res> {
  _$SkillEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SkillEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skillCode = null,
    Object? skillName = null,
    Object? skillDescription = null,
    Object? levelRestriction = null,
    Object? coolDown = null,
    Object? skillType = null,
    Object? level = freezed,
  }) {
    return _then(_value.copyWith(
      skillCode: null == skillCode
          ? _value.skillCode
          : skillCode // ignore: cast_nullable_to_non_nullable
              as String,
      skillName: null == skillName
          ? _value.skillName
          : skillName // ignore: cast_nullable_to_non_nullable
              as String,
      skillDescription: null == skillDescription
          ? _value.skillDescription
          : skillDescription // ignore: cast_nullable_to_non_nullable
              as String,
      levelRestriction: null == levelRestriction
          ? _value.levelRestriction
          : levelRestriction // ignore: cast_nullable_to_non_nullable
              as int,
      coolDown: null == coolDown
          ? _value.coolDown
          : coolDown // ignore: cast_nullable_to_non_nullable
              as int,
      skillType: null == skillType
          ? _value.skillType
          : skillType // ignore: cast_nullable_to_non_nullable
              as SkillType,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SkillEntityImplCopyWith<$Res>
    implements $SkillEntityCopyWith<$Res> {
  factory _$$SkillEntityImplCopyWith(
          _$SkillEntityImpl value, $Res Function(_$SkillEntityImpl) then) =
      __$$SkillEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String skillCode,
      String skillName,
      String skillDescription,
      int levelRestriction,
      int coolDown,
      SkillType skillType,
      dynamic level});
}

/// @nodoc
class __$$SkillEntityImplCopyWithImpl<$Res>
    extends _$SkillEntityCopyWithImpl<$Res, _$SkillEntityImpl>
    implements _$$SkillEntityImplCopyWith<$Res> {
  __$$SkillEntityImplCopyWithImpl(
      _$SkillEntityImpl _value, $Res Function(_$SkillEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of SkillEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skillCode = null,
    Object? skillName = null,
    Object? skillDescription = null,
    Object? levelRestriction = null,
    Object? coolDown = null,
    Object? skillType = null,
    Object? level = freezed,
  }) {
    return _then(_$SkillEntityImpl(
      skillCode: null == skillCode
          ? _value.skillCode
          : skillCode // ignore: cast_nullable_to_non_nullable
              as String,
      skillName: null == skillName
          ? _value.skillName
          : skillName // ignore: cast_nullable_to_non_nullable
              as String,
      skillDescription: null == skillDescription
          ? _value.skillDescription
          : skillDescription // ignore: cast_nullable_to_non_nullable
              as String,
      levelRestriction: null == levelRestriction
          ? _value.levelRestriction
          : levelRestriction // ignore: cast_nullable_to_non_nullable
              as int,
      coolDown: null == coolDown
          ? _value.coolDown
          : coolDown // ignore: cast_nullable_to_non_nullable
              as int,
      skillType: null == skillType
          ? _value.skillType
          : skillType // ignore: cast_nullable_to_non_nullable
              as SkillType,
      level: freezed == level ? _value.level! : level,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SkillEntityImpl implements _SkillEntity {
  const _$SkillEntityImpl(
      {this.skillCode = '',
      this.skillName = '',
      this.skillDescription = '',
      this.levelRestriction = 0,
      this.coolDown = 0,
      this.skillType = SkillType.attack,
      this.level = 0});

  factory _$SkillEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$SkillEntityImplFromJson(json);

  @override
  @JsonKey()
  final String skillCode;
  @override
  @JsonKey()
  final String skillName;
  @override
  @JsonKey()
  final String skillDescription;
  @override
  @JsonKey()
  final int levelRestriction;
  @override
  @JsonKey()
  final int coolDown;
  @override
  @JsonKey()
  final SkillType skillType;
  @override
  @JsonKey()
  final dynamic level;

  @override
  String toString() {
    return 'SkillEntity(skillCode: $skillCode, skillName: $skillName, skillDescription: $skillDescription, levelRestriction: $levelRestriction, coolDown: $coolDown, skillType: $skillType, level: $level)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SkillEntityImpl &&
            (identical(other.skillCode, skillCode) ||
                other.skillCode == skillCode) &&
            (identical(other.skillName, skillName) ||
                other.skillName == skillName) &&
            (identical(other.skillDescription, skillDescription) ||
                other.skillDescription == skillDescription) &&
            (identical(other.levelRestriction, levelRestriction) ||
                other.levelRestriction == levelRestriction) &&
            (identical(other.coolDown, coolDown) ||
                other.coolDown == coolDown) &&
            (identical(other.skillType, skillType) ||
                other.skillType == skillType) &&
            const DeepCollectionEquality().equals(other.level, level));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      skillCode,
      skillName,
      skillDescription,
      levelRestriction,
      coolDown,
      skillType,
      const DeepCollectionEquality().hash(level));

  /// Create a copy of SkillEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SkillEntityImplCopyWith<_$SkillEntityImpl> get copyWith =>
      __$$SkillEntityImplCopyWithImpl<_$SkillEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SkillEntityImplToJson(
      this,
    );
  }
}

abstract class _SkillEntity implements SkillEntity {
  const factory _SkillEntity(
      {final String skillCode,
      final String skillName,
      final String skillDescription,
      final int levelRestriction,
      final int coolDown,
      final SkillType skillType,
      final dynamic level}) = _$SkillEntityImpl;

  factory _SkillEntity.fromJson(Map<String, dynamic> json) =
      _$SkillEntityImpl.fromJson;

  @override
  String get skillCode;
  @override
  String get skillName;
  @override
  String get skillDescription;
  @override
  int get levelRestriction;
  @override
  int get coolDown;
  @override
  SkillType get skillType;
  @override
  dynamic get level;

  /// Create a copy of SkillEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SkillEntityImplCopyWith<_$SkillEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
