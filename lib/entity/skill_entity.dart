import 'package:freezed_annotation/freezed_annotation.dart';

part 'skill_entity.freezed.dart';

part 'skill_entity.g.dart';

@freezed
class SkillEntity with _$SkillEntity {
  const factory SkillEntity({
    @Default('') String skillCode,
    @Default('') String skillName,
    @Default('') String skillDescription,
    @Default(0) int levelRestriction,
    @Default(0) int coolDown,
    @Default(SkillType.attack) SkillType skillType,
    @Default(0) level,
  }) = _SkillEntity;

  factory SkillEntity.fromJson(Map<String, dynamic> json) => _$SkillEntityFromJson(json);
}

enum SkillType { attack, gain, recovery }
