class SkillEntity {
  SkillEntity({
    required this.skillName,
    required this.skillDescription,
    required this.levelRestriction,
    required this.coolDown,
    required this.skillType,
    this.fixedDamage,
  });

  final String skillName;
  final String skillDescription;
  final int levelRestriction;
  final int coolDown;
  final SkillType skillType;
  final int? fixedDamage;

  factory SkillEntity.fromJson(Map<String, dynamic> json) => SkillEntity(
        skillName: json["skillName"],
        skillDescription: json["skillDescription"],
        levelRestriction: json["levelRestriction"],
        coolDown: json["coolDown"],
        skillType: SkillType.values.firstWhere(
          (e) => e.toString().split('.').last == json["skillType"],
          orElse: () => SkillType.attack,
        ),
        fixedDamage: json["fixedDamage"],
      );

  Map<String, dynamic> toJson() => {
        "skillName": skillName,
        "skillDescription": skillDescription,
        "levelRestriction": levelRestriction,
        "coolDown": coolDown,
        "skillType": skillType.toString().split('.').last,
        "fixedDamage": fixedDamage,
      };
}

enum SkillType { attack, gain, recovery }
