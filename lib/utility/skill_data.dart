import 'package:rpg/entity/skill_entity.dart';

class SkillData {
  final a001 = const SkillEntity(
    skillCode: 'a001',
    skillName: '斬擊',
    skillDescription: '強力打擊敵人造成物理傷害',
    levelRestriction: 0,
    coolDown: 3,
    skillType: SkillType.attack,
    level: 1, // 初始技能
  );

  final a002 = const SkillEntity(
    skillCode: 'a002',
    skillName: '橫揮斬',
    skillDescription: '揮動武器對全體敵人造成物理傷害',
    levelRestriction: 0,
    coolDown: 3,
    skillType: SkillType.attack,
  );

  final a003 = const SkillEntity(
    skillCode: 'a003',
    skillName: '守護',
    skillDescription: '短時間增加施術者的防禦數值',
    levelRestriction: 0,
    coolDown: 3,
    skillType: SkillType.gain,
  );

  final a004 = const SkillEntity(
    skillCode: 'a004',
    skillName: '治療術',
    skillDescription: '恢復自身失去的部分生命值',
    levelRestriction: 0,
    coolDown: 3,
    skillType: SkillType.recovery,
  );
}
