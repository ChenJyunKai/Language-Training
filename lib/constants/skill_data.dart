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

  final gm001 = const SkillEntity(
    skillCode: 'gm001',
    skillName: '雙重扇形斬',
    skillDescription: '二刀流重突擊技',
    levelRestriction: 0,
    coolDown: 0,
    skillType: SkillType.attack,
  );

  final gm002 = const SkillEntity(
    skillCode: 'gm002',
    skillName: '星爆氣流斬',
    skillDescription: '十六連擊二刀流上位劍技',
    levelRestriction: 0,
    coolDown: 0,
    skillType: SkillType.attack,
  );

  final gm003 = const SkillEntity(
    skillCode: 'gm003',
    skillName: '迴旋盾',
    skillDescription: '雖說是盾，但其實是用劍快速旋轉所形成的',
    levelRestriction: 0,
    coolDown: 0,
    skillType: SkillType.gain,
  );

  final gm004 = const SkillEntity(
    skillCode: 'gm004',
    skillName: '日蝕',
    skillDescription: '二十七連擊二刀流最上位劍技',
    levelRestriction: 0,
    coolDown: 0,
    skillType: SkillType.attack,
  );
}
