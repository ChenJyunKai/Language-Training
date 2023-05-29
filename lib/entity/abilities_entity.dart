class AbilitiesEntity {
  AbilitiesEntity({
    this.role,
    this.lv = 1,
    this.exp = 50,
    this.hp = 200,
    this.mp = 50,
    this.atk = 25,
    this.def = 25,
    this.agi = 10,
    this.luk = 10,
  });

  final String? role; // 職業
  final int lv;
  final int exp;
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
hp 血量
mp 魔量
atk 攻擊力
def 防禦力
agi 敏捷
luk 幸運
 */
