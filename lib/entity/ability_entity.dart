import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rpg/entity/skill_entity.dart';

part 'ability_entity.freezed.dart';
part 'ability_entity.g.dart';

@freezed
class AbilityEntity with _$AbilityEntity {
  const factory AbilityEntity({
    String? userName, // 玩家名稱
    String? role, // 職業
    Role? roleData, // 角色資料
    @Default(0) int lv,
    @Default(0) int exp,
    @Default(0) int expL, // 下一級所需要經驗
    @Default(0) int hp,
    @Default(0) int mp,
    @Default(0) int atk,
    @Default(0) int def,
    @Default(0) int agi,
    @Default(0) int luk,
    @Default(0) int sp, // 技能點
    @Default([]) List<SkillEntity> skill,
  }) = _AbilityEntity;

  factory AbilityEntity.fromJson(Map<String, dynamic> json) => _$AbilityEntityFromJson(json);
}

@freezed
class Role with _$Role {
  const factory Role({
    String? imageAsset, // 角色圖片位置
    String? describe, // 角色敘述
  }) = _Role;

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);
}
