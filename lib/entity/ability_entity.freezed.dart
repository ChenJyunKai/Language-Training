// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ability_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AbilityEntity _$AbilityEntityFromJson(Map<String, dynamic> json) {
  return _AbilityEntity.fromJson(json);
}

/// @nodoc
mixin _$AbilityEntity {
  String? get userName => throw _privateConstructorUsedError; // 玩家名稱
  String? get role => throw _privateConstructorUsedError; // 職業
  Role? get roleData => throw _privateConstructorUsedError; // 角色資料
  int get lv => throw _privateConstructorUsedError;
  int get exp => throw _privateConstructorUsedError;
  int get expL => throw _privateConstructorUsedError; // 下一級所需要經驗
  int get hp => throw _privateConstructorUsedError;
  int get mp => throw _privateConstructorUsedError;
  int get atk => throw _privateConstructorUsedError;
  int get def => throw _privateConstructorUsedError;
  int get agi => throw _privateConstructorUsedError;
  int get luk => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AbilityEntityCopyWith<AbilityEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AbilityEntityCopyWith<$Res> {
  factory $AbilityEntityCopyWith(
          AbilityEntity value, $Res Function(AbilityEntity) then) =
      _$AbilityEntityCopyWithImpl<$Res, AbilityEntity>;
  @useResult
  $Res call(
      {String? userName,
      String? role,
      Role? roleData,
      int lv,
      int exp,
      int expL,
      int hp,
      int mp,
      int atk,
      int def,
      int agi,
      int luk});

  $RoleCopyWith<$Res>? get roleData;
}

/// @nodoc
class _$AbilityEntityCopyWithImpl<$Res, $Val extends AbilityEntity>
    implements $AbilityEntityCopyWith<$Res> {
  _$AbilityEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = freezed,
    Object? role = freezed,
    Object? roleData = freezed,
    Object? lv = null,
    Object? exp = null,
    Object? expL = null,
    Object? hp = null,
    Object? mp = null,
    Object? atk = null,
    Object? def = null,
    Object? agi = null,
    Object? luk = null,
  }) {
    return _then(_value.copyWith(
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      roleData: freezed == roleData
          ? _value.roleData
          : roleData // ignore: cast_nullable_to_non_nullable
              as Role?,
      lv: null == lv
          ? _value.lv
          : lv // ignore: cast_nullable_to_non_nullable
              as int,
      exp: null == exp
          ? _value.exp
          : exp // ignore: cast_nullable_to_non_nullable
              as int,
      expL: null == expL
          ? _value.expL
          : expL // ignore: cast_nullable_to_non_nullable
              as int,
      hp: null == hp
          ? _value.hp
          : hp // ignore: cast_nullable_to_non_nullable
              as int,
      mp: null == mp
          ? _value.mp
          : mp // ignore: cast_nullable_to_non_nullable
              as int,
      atk: null == atk
          ? _value.atk
          : atk // ignore: cast_nullable_to_non_nullable
              as int,
      def: null == def
          ? _value.def
          : def // ignore: cast_nullable_to_non_nullable
              as int,
      agi: null == agi
          ? _value.agi
          : agi // ignore: cast_nullable_to_non_nullable
              as int,
      luk: null == luk
          ? _value.luk
          : luk // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RoleCopyWith<$Res>? get roleData {
    if (_value.roleData == null) {
      return null;
    }

    return $RoleCopyWith<$Res>(_value.roleData!, (value) {
      return _then(_value.copyWith(roleData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AbilityEntityCopyWith<$Res>
    implements $AbilityEntityCopyWith<$Res> {
  factory _$$_AbilityEntityCopyWith(
          _$_AbilityEntity value, $Res Function(_$_AbilityEntity) then) =
      __$$_AbilityEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? userName,
      String? role,
      Role? roleData,
      int lv,
      int exp,
      int expL,
      int hp,
      int mp,
      int atk,
      int def,
      int agi,
      int luk});

  @override
  $RoleCopyWith<$Res>? get roleData;
}

/// @nodoc
class __$$_AbilityEntityCopyWithImpl<$Res>
    extends _$AbilityEntityCopyWithImpl<$Res, _$_AbilityEntity>
    implements _$$_AbilityEntityCopyWith<$Res> {
  __$$_AbilityEntityCopyWithImpl(
      _$_AbilityEntity _value, $Res Function(_$_AbilityEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = freezed,
    Object? role = freezed,
    Object? roleData = freezed,
    Object? lv = null,
    Object? exp = null,
    Object? expL = null,
    Object? hp = null,
    Object? mp = null,
    Object? atk = null,
    Object? def = null,
    Object? agi = null,
    Object? luk = null,
  }) {
    return _then(_$_AbilityEntity(
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      roleData: freezed == roleData
          ? _value.roleData
          : roleData // ignore: cast_nullable_to_non_nullable
              as Role?,
      lv: null == lv
          ? _value.lv
          : lv // ignore: cast_nullable_to_non_nullable
              as int,
      exp: null == exp
          ? _value.exp
          : exp // ignore: cast_nullable_to_non_nullable
              as int,
      expL: null == expL
          ? _value.expL
          : expL // ignore: cast_nullable_to_non_nullable
              as int,
      hp: null == hp
          ? _value.hp
          : hp // ignore: cast_nullable_to_non_nullable
              as int,
      mp: null == mp
          ? _value.mp
          : mp // ignore: cast_nullable_to_non_nullable
              as int,
      atk: null == atk
          ? _value.atk
          : atk // ignore: cast_nullable_to_non_nullable
              as int,
      def: null == def
          ? _value.def
          : def // ignore: cast_nullable_to_non_nullable
              as int,
      agi: null == agi
          ? _value.agi
          : agi // ignore: cast_nullable_to_non_nullable
              as int,
      luk: null == luk
          ? _value.luk
          : luk // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AbilityEntity implements _AbilityEntity {
  const _$_AbilityEntity(
      {this.userName,
      this.role,
      this.roleData,
      this.lv = 0,
      this.exp = 0,
      this.expL = 0,
      this.hp = 0,
      this.mp = 0,
      this.atk = 0,
      this.def = 0,
      this.agi = 0,
      this.luk = 0});

  factory _$_AbilityEntity.fromJson(Map<String, dynamic> json) =>
      _$$_AbilityEntityFromJson(json);

  @override
  final String? userName;
// 玩家名稱
  @override
  final String? role;
// 職業
  @override
  final Role? roleData;
// 角色資料
  @override
  @JsonKey()
  final int lv;
  @override
  @JsonKey()
  final int exp;
  @override
  @JsonKey()
  final int expL;
// 下一級所需要經驗
  @override
  @JsonKey()
  final int hp;
  @override
  @JsonKey()
  final int mp;
  @override
  @JsonKey()
  final int atk;
  @override
  @JsonKey()
  final int def;
  @override
  @JsonKey()
  final int agi;
  @override
  @JsonKey()
  final int luk;

  @override
  String toString() {
    return 'AbilityEntity(userName: $userName, role: $role, roleData: $roleData, lv: $lv, exp: $exp, expL: $expL, hp: $hp, mp: $mp, atk: $atk, def: $def, agi: $agi, luk: $luk)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AbilityEntity &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.roleData, roleData) ||
                other.roleData == roleData) &&
            (identical(other.lv, lv) || other.lv == lv) &&
            (identical(other.exp, exp) || other.exp == exp) &&
            (identical(other.expL, expL) || other.expL == expL) &&
            (identical(other.hp, hp) || other.hp == hp) &&
            (identical(other.mp, mp) || other.mp == mp) &&
            (identical(other.atk, atk) || other.atk == atk) &&
            (identical(other.def, def) || other.def == def) &&
            (identical(other.agi, agi) || other.agi == agi) &&
            (identical(other.luk, luk) || other.luk == luk));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userName, role, roleData, lv,
      exp, expL, hp, mp, atk, def, agi, luk);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AbilityEntityCopyWith<_$_AbilityEntity> get copyWith =>
      __$$_AbilityEntityCopyWithImpl<_$_AbilityEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AbilityEntityToJson(
      this,
    );
  }
}

abstract class _AbilityEntity implements AbilityEntity {
  const factory _AbilityEntity(
      {final String? userName,
      final String? role,
      final Role? roleData,
      final int lv,
      final int exp,
      final int expL,
      final int hp,
      final int mp,
      final int atk,
      final int def,
      final int agi,
      final int luk}) = _$_AbilityEntity;

  factory _AbilityEntity.fromJson(Map<String, dynamic> json) =
      _$_AbilityEntity.fromJson;

  @override
  String? get userName;
  @override // 玩家名稱
  String? get role;
  @override // 職業
  Role? get roleData;
  @override // 角色資料
  int get lv;
  @override
  int get exp;
  @override
  int get expL;
  @override // 下一級所需要經驗
  int get hp;
  @override
  int get mp;
  @override
  int get atk;
  @override
  int get def;
  @override
  int get agi;
  @override
  int get luk;
  @override
  @JsonKey(ignore: true)
  _$$_AbilityEntityCopyWith<_$_AbilityEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

Role _$RoleFromJson(Map<String, dynamic> json) {
  return _Role.fromJson(json);
}

/// @nodoc
mixin _$Role {
  String? get imageAsset => throw _privateConstructorUsedError; // 角色圖片位置
  String? get describe => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoleCopyWith<Role> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoleCopyWith<$Res> {
  factory $RoleCopyWith(Role value, $Res Function(Role) then) =
      _$RoleCopyWithImpl<$Res, Role>;
  @useResult
  $Res call({String? imageAsset, String? describe});
}

/// @nodoc
class _$RoleCopyWithImpl<$Res, $Val extends Role>
    implements $RoleCopyWith<$Res> {
  _$RoleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageAsset = freezed,
    Object? describe = freezed,
  }) {
    return _then(_value.copyWith(
      imageAsset: freezed == imageAsset
          ? _value.imageAsset
          : imageAsset // ignore: cast_nullable_to_non_nullable
              as String?,
      describe: freezed == describe
          ? _value.describe
          : describe // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RoleCopyWith<$Res> implements $RoleCopyWith<$Res> {
  factory _$$_RoleCopyWith(_$_Role value, $Res Function(_$_Role) then) =
      __$$_RoleCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? imageAsset, String? describe});
}

/// @nodoc
class __$$_RoleCopyWithImpl<$Res> extends _$RoleCopyWithImpl<$Res, _$_Role>
    implements _$$_RoleCopyWith<$Res> {
  __$$_RoleCopyWithImpl(_$_Role _value, $Res Function(_$_Role) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageAsset = freezed,
    Object? describe = freezed,
  }) {
    return _then(_$_Role(
      imageAsset: freezed == imageAsset
          ? _value.imageAsset
          : imageAsset // ignore: cast_nullable_to_non_nullable
              as String?,
      describe: freezed == describe
          ? _value.describe
          : describe // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Role implements _Role {
  const _$_Role({this.imageAsset, this.describe});

  factory _$_Role.fromJson(Map<String, dynamic> json) => _$$_RoleFromJson(json);

  @override
  final String? imageAsset;
// 角色圖片位置
  @override
  final String? describe;

  @override
  String toString() {
    return 'Role(imageAsset: $imageAsset, describe: $describe)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Role &&
            (identical(other.imageAsset, imageAsset) ||
                other.imageAsset == imageAsset) &&
            (identical(other.describe, describe) ||
                other.describe == describe));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, imageAsset, describe);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RoleCopyWith<_$_Role> get copyWith =>
      __$$_RoleCopyWithImpl<_$_Role>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RoleToJson(
      this,
    );
  }
}

abstract class _Role implements Role {
  const factory _Role({final String? imageAsset, final String? describe}) =
      _$_Role;

  factory _Role.fromJson(Map<String, dynamic> json) = _$_Role.fromJson;

  @override
  String? get imageAsset;
  @override // 角色圖片位置
  String? get describe;
  @override
  @JsonKey(ignore: true)
  _$$_RoleCopyWith<_$_Role> get copyWith => throw _privateConstructorUsedError;
}
