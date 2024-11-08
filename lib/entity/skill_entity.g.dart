// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SkillEntityImpl _$$SkillEntityImplFromJson(Map<String, dynamic> json) =>
    _$SkillEntityImpl(
      skillCode: json['skillCode'] as String? ?? '',
      skillName: json['skillName'] as String? ?? '',
      skillDescription: json['skillDescription'] as String? ?? '',
      levelRestriction: (json['levelRestriction'] as num?)?.toInt() ?? 0,
      coolDown: (json['coolDown'] as num?)?.toInt() ?? 0,
      skillType: $enumDecodeNullable(_$SkillTypeEnumMap, json['skillType']) ??
          SkillType.attack,
      level: json['level'] ?? 0,
    );

Map<String, dynamic> _$$SkillEntityImplToJson(_$SkillEntityImpl instance) =>
    <String, dynamic>{
      'skillCode': instance.skillCode,
      'skillName': instance.skillName,
      'skillDescription': instance.skillDescription,
      'levelRestriction': instance.levelRestriction,
      'coolDown': instance.coolDown,
      'skillType': _$SkillTypeEnumMap[instance.skillType]!,
      'level': instance.level,
    };

const _$SkillTypeEnumMap = {
  SkillType.attack: 'attack',
  SkillType.gain: 'gain',
  SkillType.recovery: 'recovery',
};
