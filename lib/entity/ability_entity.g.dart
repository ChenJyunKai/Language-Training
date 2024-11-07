// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ability_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AbilityEntityImpl _$$AbilityEntityImplFromJson(Map<String, dynamic> json) =>
    _$AbilityEntityImpl(
      userName: json['userName'] as String?,
      role: json['role'] as String?,
      roleData: json['roleData'] == null
          ? null
          : Role.fromJson(json['roleData'] as Map<String, dynamic>),
      lv: (json['lv'] as num?)?.toInt() ?? 0,
      exp: (json['exp'] as num?)?.toInt() ?? 0,
      expL: (json['expL'] as num?)?.toInt() ?? 0,
      hp: (json['hp'] as num?)?.toInt() ?? 0,
      mp: (json['mp'] as num?)?.toInt() ?? 0,
      atk: (json['atk'] as num?)?.toInt() ?? 0,
      def: (json['def'] as num?)?.toInt() ?? 0,
      agi: (json['agi'] as num?)?.toInt() ?? 0,
      luk: (json['luk'] as num?)?.toInt() ?? 0,
      skillLv: (json['skillLv'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [0, 0, 0, 0],
    );

Map<String, dynamic> _$$AbilityEntityImplToJson(_$AbilityEntityImpl instance) =>
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
      'skillLv': instance.skillLv,
    };

_$RoleImpl _$$RoleImplFromJson(Map<String, dynamic> json) => _$RoleImpl(
      imageAsset: json['imageAsset'] as String?,
      describe: json['describe'] as String?,
    );

Map<String, dynamic> _$$RoleImplToJson(_$RoleImpl instance) =>
    <String, dynamic>{
      'imageAsset': instance.imageAsset,
      'describe': instance.describe,
    };
