import 'package:rpg/entity/role_entity.dart';

class AbilitiesEntity {
  AbilitiesEntity({
    this.role,
    this.roleData,
    this.lv = 1,
    this.exp = 750,
    this.expL = 750,
    this.hp = 200,
    this.mp = 50,
    this.atk = 25,
    this.def = 25,
    this.agi = 10,
    this.luk = 10,
  });

  AbilitiesEntity copyWith(String? role) {
    return AbilitiesEntity(
      role: role ?? this.role,
    );
  }

  final String? role; // 職業
  final RoleEntity? roleData; // 角色資料
  final int lv;
  final int exp;
  final int expL;
  final int hp;
  final int mp;
  final int atk;
  final int def;
  final int agi;
  final int luk;
}

/*
lv 等級
exp 經驗值
exp_l 下一級所需經驗
hp 血量
mp 魔量
atk 攻擊力
def 防禦力
agi 敏捷
luk 幸運
 */
