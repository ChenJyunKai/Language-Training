// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ability_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AbilityEntity _$$_AbilityEntityFromJson(Map<String, dynamic> json) =>
    _$_AbilityEntity(
      userName: json['userName'] as String?,
      role: json['role'] as String?,
      roleData: json['roleData'] == null
          ? null
          : Role.fromJson(json['roleData'] as Map<String, dynamic>),
      lv: json['lv'] as int? ?? 0,
      exp: json['exp'] as int? ?? 0,
      expL: json['expL'] as int? ?? 0,
      hp: json['hp'] as int? ?? 0,
      mp: json['mp'] as int? ?? 0,
      atk: json['atk'] as int? ?? 0,
      def: json['def'] as int? ?? 0,
      agi: json['agi'] as int? ?? 0,
      luk: json['luk'] as int? ?? 0,
    );

Map<String, dynamic> _$$_AbilityEntityToJson(_$_AbilityEntity instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'role': instance.role,
      'roleData': instance.roleData,
      'lv': instance.lv,
      'exp': instance.exp,
      'expL': instance.expL,
      'hp': instance.hp,
      'mp': instance.mp,
      'atk': instance.atk,
      'def': instance.def,
      'agi': instance.agi,
      'luk': instance.luk,
    };

_$_Role _$$_RoleFromJson(Map<String, dynamic> json) => _$_Role(
      imageAsset: json['imageAsset'] as String?,
      describe: json['describe'] as String?,
    );

Map<String, dynamic> _$$_RoleToJson(_$_Role instance) => <String, dynamic>{
      'imageAsset': instance.imageAsset,
      'describe': instance.describe,
    };
